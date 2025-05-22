import 'package:flutter/material.dart';
import 'package:keno_plus/features/gameplay/presentation/payout_bloc/payout_state.dart';

void resultDialog(BuildContext context, PayoutState state) {
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
                ...state.cardPayouts!.entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('Spots: ${entry.value.spots}'),
                        Text('Catches: ${entry.value.catches}'),
                        Text(
                          'Amount Won: \$${entry.value.amountWon.toStringAsFixed(2)}',
                          style: TextStyle(
                            color:
                                entry.value.amountWon > 0
                                    ? Colors.green
                                    : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Total Won: \$${state.totalAmountWon.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: state.totalAmountWon > 0 ? Colors.green : Colors.red,
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
