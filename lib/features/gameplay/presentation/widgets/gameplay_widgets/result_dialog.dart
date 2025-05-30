import 'package:flutter/material.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/ticket_widgets/number_box.dart';

void showResultDialog(BuildContext context, List<TicketBloc> tickets) {
  if (tickets.isEmpty) {
    return;
  }

  double totalAmountWon = 0;

  // Calculate total amount won and check for errors
  for (final ticket in tickets) {
    final state = ticket.state;
    totalAmountWon += state.payout ?? 0.0;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => AlertDialog(
          title: Text('Game Results'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    NumberBox(
                      number: 8,
                      isSelected: true,
                      isMatch: true,
                      isWinningSpot: true,
                      onTap: () {},
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '= Catch (Winning Spot)',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    NumberBox(
                      number: 12,
                      isSelected: true,
                      isMatch: false,
                      isWinningSpot: false,
                      onTap: () {},
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '= Spot (Non-winning)',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    NumberBox(
                      number: 20,
                      isSelected: false,
                      isMatch: true,
                      isWinningSpot: false,
                      onTap: () {},
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '= Winning Number (Not Selected)',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const Divider(),
                ...tickets.asMap().entries.map((entry) {
                  final index = entry.key + 1;
                  final state = entry.value.state;
                  final spots = state.spots;
                  final catches = state.catches;
                  final amountWon = state.payout ?? 0.0;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ticket $index',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text('Spots:'),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            for (final n in spots)
                              NumberBox(
                                number: n,
                                isSelected: true,
                                isMatch: catches.contains(n),
                                isWinningSpot:
                                    amountWon > 0 && catches.contains(n),
                                onTap: () {},
                              ),
                            for (final n in catches.where(
                              (n) => !spots.contains(n),
                            ))
                              NumberBox(
                                number: n,
                                isSelected: false,
                                isMatch: true,
                                isWinningSpot: false,
                                onTap: () {},
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Amount Won: ₱${amountWon.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: amountWon > 0 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Text(
                  'Total Won: ₱${totalAmountWon.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: totalAmountWon > 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
  );
}
