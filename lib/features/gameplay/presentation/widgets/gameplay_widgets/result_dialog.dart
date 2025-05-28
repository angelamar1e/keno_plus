import 'package:flutter/material.dart';
import 'package:keno_plus/features/gameplay/presentation/card_bloc/card_bloc.dart';
import 'package:keno_plus/features/gameplay/presentation/widgets/card_widgets/number_box.dart';

void showResultDialog(BuildContext context, List<CardBloc> tickets) {
  double totalAmountWon = 0;

  // Determine all numbers that are catches (drawn numbers) across all tickets
  final allCatches = <int>{};
  for (final ticket in tickets) {
    allCatches.addAll(ticket.state.catches);
  }

  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: const Text('Game Results'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Legend
                Row(
                  children: [
                    NumberBox(
                      number: 8,
                      isSelected: true,
                      isMatch: true,
                      isWinningBet: true,
                      onTap: () {},
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '= Catch (Winning Bet)',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 12),
                    NumberBox(
                      number: 12,
                      isSelected: true,
                      isMatch: false,
                      isWinningBet: false,
                      onTap: () {},
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '= Spot (Non-winning)',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 12),
                    NumberBox(
                      number: 20,
                      isSelected: false,
                      isMatch: true,
                      isWinningBet: false,
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
                  totalAmountWon += amountWon;
                  // For this ticket, show all spots in a row, color-coded
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
                        Text('Spots:'),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            for (final n in spots)
                              NumberBox(
                                number: n,
                                isSelected: true,
                                isMatch: catches.contains(n),
                                isWinningBet:
                                    amountWon > 0 && catches.contains(n),
                                onTap: () {},
                              ),
                            // Show catches that are not in spots (winning numbers not selected)
                            for (final n in catches.where(
                              (n) => !spots.contains(n),
                            ))
                              NumberBox(
                                number: n,
                                isSelected: false,
                                isMatch: true,
                                isWinningBet: false,
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
                  'Total Won: ₱$totalAmountWon',
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
