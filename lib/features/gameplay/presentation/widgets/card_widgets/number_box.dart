import 'package:keno_plus/core/values/app_imports.dart';

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
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              isMatch
                  ? AppColors.cardWin
                  : isWinningBet
                  ? AppColors.cardLose
                  : (isSelected
                      ? AppColors.cardSelected
                      : AppColors.cardPrimary),
          border: Border.all(color: AppColors.white, width: 1),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.white.withOpacity(0.5),
              blurRadius: 2.0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: KenoText(
          text: number.toString(),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: isSelected ? AppColors.primary : AppColors.white,
        ),
      ),
    );
  }
}
