class WordProgress {
  final String word;

  int attempts;
  int correct;
  int wrong;
  int points;

  DateTime? lastAttempt;
  DateTime? nextRevision;

  String? lastWrongAnswer;
  String? correctAnswer;

  int revisionLevel;

  WordProgress({
    required this.word,
    this.attempts = 0,
    this.correct = 0,
    this.wrong = 0,
    this.points = 0,
    this.lastAttempt,
    this.nextRevision,
    this.lastWrongAnswer,
    this.correctAnswer,
    this.revisionLevel = 0,
  });

  double get accuracy {
    if (attempts == 0) {
      return 0;
    }

    return correct / attempts;
  }

  bool get needsRevision {
    if (nextRevision == null) {
      return false;
    }

    return DateTime.now().isAfter(nextRevision!);
  }

  void recordCorrect({
    int earnedPoints = 10,
  }) {
    attempts++;
    correct++;
    points += earnedPoints;

    lastAttempt = DateTime.now();

    _setNextRevision();
  }

  void recordWrong({
    String? userAnswer,
    String? answer,
  }) {
    attempts++;
    wrong++;

    lastAttempt = DateTime.now();

    lastWrongAnswer = userAnswer;
    correctAnswer = answer;

    // गलत होने पर जल्दी दोबारा revision
    nextRevision = DateTime.now().add(
      const Duration(hours: 24),
    );
  }

  void _setNextRevision() {
    switch (revisionLevel) {
      case 0:
        revisionLevel = 1;

        nextRevision = DateTime.now().add(
          const Duration(hours: 24),
        );
        break;

      case 1:
        revisionLevel = 2;

        nextRevision = DateTime.now().add(
          const Duration(days: 7),
        );
        break;

      case 2:
      default:
        revisionLevel = 3;

        nextRevision = DateTime.now().add(
          const Duration(days: 30),
        );
        break;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'attempts': attempts,
      'correct': correct,
      'wrong': wrong,
      'points': points,
      'lastAttempt': lastAttempt?.toIso8601String(),
      'nextRevision': nextRevision?.toIso8601String(),
      'lastWrongAnswer': lastWrongAnswer,
      'correctAnswer': correctAnswer,
      'revisionLevel': revisionLevel,
    };
  }

  factory WordProgress.fromMap(
    Map<String, dynamic> map,
  ) {
    return WordProgress(
      word: map['word'] ?? '',
      attempts: map['attempts'] ?? 0,
      correct: map['correct'] ?? 0,
      wrong: map['wrong'] ?? 0,
      points: map['points'] ?? 0,
      lastAttempt: map['lastAttempt'] != null
          ? DateTime.tryParse(map['lastAttempt'])
          : null,
      nextRevision: map['nextRevision'] != null
          ? DateTime.tryParse(map['nextRevision'])
          : null,
      lastWrongAnswer:
          map['lastWrongAnswer'],
      correctAnswer:
          map['correctAnswer'],
      revisionLevel:
          map['revisionLevel'] ?? 0,
    );
  }
}


class LearningProgressService {
  final Map<String, WordProgress> _progress = {};

  int get totalPoints {
    return _progress.values.fold(
      0,
      (sum, item) => sum + item.points,
    );
  }

  WordProgress getProgress(String word) {
    return _progress.putIfAbsent(
      word,
      () => WordProgress(word: word),
    );
  }

  void correctAnswer(
    String word, {
    int points = 10,
  }) {
    final progress = getProgress(word);

    progress.recordCorrect(
      earnedPoints: points,
    );
  }

  void wrongAnswer(
    String word, {
    String? userAnswer,
    String? correctAnswer,
  }) {
    final progress = getProgress(word);

    progress.recordWrong(
      userAnswer: userAnswer,
      answer: correctAnswer,
    );
  }

  List<WordProgress> getWordsForRevision() {
    return _progress.values
        .where(
          (item) => item.needsRevision,
        )
        .toList();
  }

  List<WordProgress> getMistakes() {
    return _progress.values
        .where(
          (item) => item.wrong > 0,
        )
        .toList();
  }

  List<WordProgress> getCompletedWords() {
    return _progress.values
        .where(
          (item) => item.correct > 0,
        )
        .toList();
  }

  void clearProgress(String word) {
    _progress.remove(word);
  }

  void clearAllProgress() {
    _progress.clear();
  }
}
