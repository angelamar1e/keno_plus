class GameHistoryState {
  final bool isSaving;
  final bool isSaved;
  final int? newGameHistoryId;

  const GameHistoryState({
    this.newGameHistoryId,
    required this.isSaving,
    required this.isSaved,
  });

  factory GameHistoryState.initial() => const GameHistoryState(
    newGameHistoryId: null,
    isSaving: false,
    isSaved: false,
  );
  GameHistoryState copyWith({
    int? newGameHistoryId,
    bool? isSaving,
    bool? isSaved,
  }) {
    return GameHistoryState(
      newGameHistoryId: newGameHistoryId ?? this.newGameHistoryId,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
