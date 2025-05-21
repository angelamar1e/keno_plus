class GameHistoryState {
  final bool isSaving;
  final String? error;
  final bool isSaved;

  const GameHistoryState({
    required this.isSaving,
    this.error,
    required this.isSaved,
  });

  factory GameHistoryState.initial() => const GameHistoryState(
        isSaving: false,
        isSaved: false,
      );

  GameHistoryState copyWith({
    bool? isSaving,
    String? error,
    bool? isSaved,
  }) {
    return GameHistoryState(
      isSaving: isSaving ?? this.isSaving,
      error: error,
      isSaved: isSaved ?? this.isSaved,
    );
  }
} 