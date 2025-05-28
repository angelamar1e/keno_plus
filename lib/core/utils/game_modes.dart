enum GameMode {
  classic(maxBets: 15, rows: 10, columns: 8),
  mini(maxBets: 7, rows: 7, columns: 7);

  final int maxBets;
  final int rows;
  final int columns;
  
  get numbersCount => rows * columns;

  const GameMode({
    required this.maxBets,
    required this.rows,
    required this.columns,
  });
}
