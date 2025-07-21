import 'package:flutter/material.dart';
import 'package:keno_plus/features/gameplay/presentation/ticket_bloc/ticket_bloc.dart';

class ResultNumberBox extends StatelessWidget {
  const ResultNumberBox({
    super.key,
    required this.number,
    required this.isSelected,
    required this.isCatch,
    required this.isWinningSpot,
  });

  final int number;
  final bool isSelected;
  final bool isCatch;
  final bool isWinningSpot;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _getBorderColor(), width: 2),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            color: _getTextColor(),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (!isSelected) {
      return Colors.grey.shade100;
    }
    if (isWinningSpot) {
      return Colors.green.shade100;
    }
    if (isCatch) {
      return Colors.green.shade100;
    }
    return Colors.white;
  }

  Color _getBorderColor() {
    if (isWinningSpot) {
      return Colors.green;
    }
    if (isCatch) {
      return Colors.blue;
    }
    return Colors.grey.shade300;
  }

  Color _getTextColor() {
    if (isWinningSpot) {
      return Colors.green.shade800;
    }
    if (isCatch) {
      return Colors.blue.shade800;
    }
    return Colors.black87;
  }
}

class ResultDialog extends StatefulWidget {
  const ResultDialog({
    super.key,
    required this.tickets,
    required this.totalAmountWon,
  });

  final List<TicketBloc> tickets;
  final double totalAmountWon;

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  int selectedTicketIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          const Text('Game Results'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.totalAmountWon > 0
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Total Won: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₱${widget.totalAmountWon.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: widget.totalAmountWon > 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ticket Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  widget.tickets.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text('Ticket ${index + 1}'),
                      selected: selectedTicketIndex == index,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            selectedTicketIndex = index;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Selected Ticket Details
            Builder(
              builder: (context) {
                final ticket = widget.tickets[selectedTicketIndex];
                final state = ticket.state;
                final spots = state.spots;
                final catches = state.catches;
                final amountWon = state.payout ?? 0.0;
                final winningNumbers = state.winningSpots;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount Won: ₱${amountWon.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: amountWon > 0 ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Your Numbers:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: spots
                          .map(
                            (n) => ResultNumberBox(
                              number: n,
                              isSelected: true,
                              isCatch: catches.contains(n),
                              isWinningSpot: catches.contains(n),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Winning Numbers:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: winningNumbers
                          .map(
                            (n) => ResultNumberBox(
                              number: n,
                              isSelected: spots.contains(n),
                              isCatch: spots.contains(n),
                              isWinningSpot: true,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                );
              },
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
    );
  }
}

void showResultDialog(BuildContext context, List<TicketBloc> tickets) {
  if (tickets.isEmpty) {
    return;
  }

  double totalAmountWon = 0;
  for (final ticket in tickets) {
    totalAmountWon += ticket.state.payout ?? 0.0;
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => ResultDialog(
      tickets: tickets,
      totalAmountWon: totalAmountWon,
    ),
  );
}
