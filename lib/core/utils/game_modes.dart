enum GameMode {
  classic(maxSpots: 15, rows: 10, columns: 8),
  mini(maxSpots: 7, rows: 7, columns: 7);

  final int maxSpots;
  final int rows;
  final int columns;

  get numbersCount => rows * columns;

  const GameMode({
    required this.maxSpots,
    required this.rows,
    required this.columns,
  });
}
