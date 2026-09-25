class MistakeRecord {
  final String word;
  final String exerciseType;

  final String userAnswer;
  final String correctAnswer;

  final DateTime createdAt;

  int attempts;
  bool corrected;

  MistakeRecord({
    required this.word,
    required this.exerciseType,
    required this.userAnswer,
    required this.correctAnswer,
    DateTime? createdAt,
    this.attempts = 1,
    this.corrected = false,
  }) : createdAt = createdAt ?? DateTime.now();

  void retry({
    required bool isCorrect,
  }) {
    attempts++;

    if (isCorrect) {
      corrected = true;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'exerciseType': exerciseType,
      'userAnswer': userAnswer,
      'correctAnswer': correctAnswer,
      'createdAt': createdAt.toIso8601String(),
      'attempts': attempts,
      'corrected': corrected,
    };
  }

  factory MistakeRecord.fromMap(
    Map<String, dynamic> map,
  ) {
    return MistakeRecord(
      word: map['word'] ?? '',
      exerciseType: map['exerciseType'] ?? '',
      userAnswer: map['userAnswer'] ?? '',
      correctAnswer: map['correctAnswer'] ?? '',
      createdAt: DateTime.tryParse(
            map['createdAt'] ?? '',
          ) ??
          DateTime.now(),
      attempts: map['attempts'] ?? 1,
      corrected: map['corrected'] ?? false,
    );
  }
}


class MistakeBankService {
  final List<MistakeRecord> _mistakes = [];

  List<MistakeRecord> get allMistakes {
    return List.unmodifiable(_mistakes);
  }

  List<MistakeRecord> get pendingMistakes {
    return _mistakes
        .where(
          (mistake) => !mistake.corrected,
        )
        .toList();
  }

  int get totalMistakes {
    return _mistakes.length;
  }

  int get pendingCount {
    return pendingMistakes.length;
  }

  void addMistake({
    required String word,
    required String exerciseType,
    required String userAnswer,
    required String correctAnswer,
  }) {
    final existingIndex = _mistakes.indexWhere(
      (mistake) =>
          mistake.word == word &&
          mistake.exerciseType == exerciseType &&
          !mistake.corrected,
    );

    if (existingIndex != -1) {
      _mistakes[existingIndex].attempts++;
      return;
    }

    _mistakes.add(
      MistakeRecord(
        word: word,
        exerciseType: exerciseType,
        userAnswer: userAnswer,
        correctAnswer: correctAnswer,
      ),
    );
  }

  void retryMistake(
    MistakeRecord mistake, {
    required bool isCorrect,
  }) {
    mistake.retry(
      isCorrect: isCorrect,
    );
  }

  void removeCorrectedMistakes() {
    _mistakes.removeWhere(
      (mistake) => mistake.corrected,
    );
  }

  void clearAll() {
    _mistakes.clear();
  }
}
