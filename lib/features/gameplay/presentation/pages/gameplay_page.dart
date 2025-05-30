import 'package:keno_plus/core/values/app_imports.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/game_config_bloc/game_config_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/ticket_widgets/ticket_widget.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/auto_pick_button.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/auto_pick_slider.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/play_button.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/gameplay_widgets/wager_controls.dart';

class GameplayPage extends StatefulWidget {
  const GameplayPage({super.key});

  @override
  State<GameplayPage> createState() => _GameplayPageState();
}

class _GameplayPageState extends State<GameplayPage> {
  late final PageController pageController;
  final Map<int, TicketBloc> ticketBlocInstances = {};

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameConfigBloc, GameConfigState>(
      listener: (context, state) {
        pageController.animateToPage(
          state.currentTicket,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: BlocBuilder<GameConfigBloc, GameConfigState>(
        builder: (context, state) {
          // Ensure the currentTicketBloc is retrieved from the map
          if (!ticketBlocInstances.containsKey(state.currentTicket)) {
            ticketBlocInstances[state.currentTicket] = TicketBloc();
          }

          final currentTicketBloc =
              ticketBlocInstances[state.currentTicket] ?? TicketBloc();
          final numberOfTickets =
              state.numberOfTickets; // number of purchased tickets
          final gameMode = state.gameMode;

          return KenoMainLayout(
            background: KenoGameBackground(),
            topBar: KenoTopBar(text: 'Classic Keno'),
            content: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: state.numberOfTickets,
                    onPageChanged: (index) {
                      context.read<GameConfigBloc>().add(
                        UpdateCurrentTicket(index),
                      );
                    },
                    itemBuilder: (context, index) {
                      if (!ticketBlocInstances.containsKey(index)) {
                        ticketBlocInstances[index] = TicketBloc();
                      }

                      return BlocProvider.value(
                        value: ticketBlocInstances[index]!,
                        child: TicketWidget(gameMode),
                      );
                    },
                  ),
                ),

                // Bottom controls - now in a SafeArea to avoid overflow
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KenoButton(
                      onPressed:
                          state.currentTicket > 0
                              ? () {
                                // Navigate to the previous ticket
                                context.read<GameConfigBloc>().add(
                                  UpdateCurrentTicket(state.currentTicket - 1),
                                );
                              }
                              : null,
                      icon: Icons.arrow_back,
                    ),
                    const SizedBox(width: 16),
                    KenoButton(
                      onPressed:
                          state.currentTicket < numberOfTickets - 1
                              ? () {
                                // Navigate to the next ticket
                                context.read<GameConfigBloc>().add(
                                  UpdateCurrentTicket(state.currentTicket + 1),
                                );
                              }
                              : null,
                      icon: Icons.arrow_forward,
                    ),
                  ],
                ),
                // Wager controls
                const WagerControls(),
                Row(
                  children: [
                    // AutoPickNumberSlider takes most of the space
                    Expanded(
                      child: AutoPickNumberSlider(
                        ticketBlocInstance: currentTicketBloc,
                        gameMode,
                      ),
                    ),
                    // Button takes less space
                    AutoPickButton(
                      ticketBlocInstance: currentTicketBloc,
                      gameMode,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                PlayButton(
                  ticketBlocInstances: ticketBlocInstances.values.toList(),
                  gameMode: gameMode,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
