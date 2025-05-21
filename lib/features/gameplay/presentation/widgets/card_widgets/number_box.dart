import 'package:flutter/material.dart';

class NumberBox extends StatelessWidget {
  final int number;
  final bool isSelected;
  final bool isMatch;
  final bool isWinningBet;
  final VoidCallback onTap;

  const NumberBox({
    super.key,
    required this.number,
    required this.isSelected,
    required this.isMatch,
    required this.isWinningBet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              isMatch
                  ? Colors.green
                  : isWinningBet
                  ? Colors.red
                  : (isSelected ? Colors.blue : Colors.grey[300]),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          number.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
