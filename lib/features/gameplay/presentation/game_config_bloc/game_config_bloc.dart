import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keno_plus/core/utils/game_modes.dart';

part 'game_config_event.dart';
part 'game_config_state.dart';

class GameConfigBloc extends Bloc<GameConfigEvent, GameConfigState> {
  GameConfigBloc() : super(GameConfigState.initial()) {
    on<GameConfigEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
