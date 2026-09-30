import 'learning_progress_service.dart';
import 'mistake_bank_service.dart';

class ExerciseResultService {
  final LearningProgressService progressService;
  final MistakeBankService mistakeBankService;

  ExerciseResultService({
    required this.progressService,
    required this.mistakeBankService,
  });

  int submitAnswer({
    required String word,
    required String exerciseType,
    required String userAnswer,
    required String correctAnswer,
    int correctPoints = 10,
  }) {
    final isCorrect =
        userAnswer.trim().toLowerCase() ==
            correctAnswer.trim().toLowerCase();

    if (isCorrect) {
      progressService.correctAnswer(
        word,
        points: correctPoints,
      );

      return correctPoints;
    }

    progressService.wrongAnswer(
      word,
      userAnswer: userAnswer,
      correctAnswer: correctAnswer,
    );

    mistakeBankService.addMistake(
      word: word,
      exerciseType: exerciseType,
      userAnswer: userAnswer,
      correctAnswer: correctAnswer,
    );

    return 0;
  }

  int submitSentence({
    required String word,
    required String userSentence,
    required String correctSentence,
    int points = 15,
  }) {
    final isCorrect =
        userSentence.trim().toLowerCase() ==
            correctSentence.trim().toLowerCase();

    if (isCorrect) {
      progressService.correctAnswer(
        word,
        points: points,
      );

      return points;
    }

    progressService.wrongAnswer(
      word,
      userAnswer: userSentence,
      correctAnswer: correctSentence,
    );

    mistakeBankService.addMistake(
      word: word,
      exerciseType: 'sentence',
      userAnswer: userSentence,
      correctAnswer: correctSentence,
    );

    return 0;
  }

  int submitFillBlank({
    required String word,
    required String userAnswer,
    required String correctAnswer,
    int points = 10,
  }) {
    return submitAnswer(
      word: word,
      exerciseType: 'fill_blank',
      userAnswer: userAnswer,
      correctAnswer: correctAnswer,
      correctPoints: points,
    );
  }

  int submitMcq({
    required String word,
    required String userAnswer,
    required String correctAnswer,
    int points = 10,
  }) {
    return submitAnswer(
      word: word,
      exerciseType: 'mcq',
      userAnswer: userAnswer,
      correctAnswer: correctAnswer,
      correctPoints: points,
    );
  }

  int submitWriting({
    required String word,
    required String userAnswer,
    required String correctAnswer,
    int points = 15,
  }) {
    return submitAnswer(
      word: word,
      exerciseType: 'writing',
      userAnswer: userAnswer,
      correctAnswer: correctAnswer,
      correctPoints: points,
    );
  }

  int submitGrammar({
    required String word,
    required String userAnswer,
    required String correctAnswer,
    int points = 10,
  }) {
    return submitAnswer(
      word: word,
      exerciseType: 'grammar',
      userAnswer: userAnswer,
      correctAnswer: correctAnswer,
      correctPoints: points,
    );
  }
}
