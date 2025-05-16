enum GameMode {
  classic(maxBets: 15, rows: 8, columns: 10),
  mini(maxBets: 7, rows: 7, columns: 7);

  final int maxBets;
  final int rows;
  final int columns;

  const GameMode({
    required this.maxBets,
    required this.rows,
    required this.columns,
  });
}
