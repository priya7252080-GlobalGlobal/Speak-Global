import 'dart:math';
import 'package:flutter/material.dart';

class PracticeScreen extends StatefulWidget {
  final List<Map<String, String>> words;
  final String startingLanguage;

  const PracticeScreen({
    super.key,
    required this.words,
    this.startingLanguage = 'hindi',
  });

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final Random _random = Random();

  int currentIndex = 0;
  int score = 0;
  int totalAnswered = 0;

  String questionLanguage = 'hindi';
  String answerLanguage = 'american';

  List<String> options = [];
  String correctAnswer = '';
  String selectedAnswer = '';
  bool answered = false;

  Map<String, String> get currentWord =>
      widget.words[currentIndex];

  @override
  void initState() {
    super.initState();
    _createQuestion();
  }

  String _getValue(
    Map<String, String> word,
    String language,
  ) {
    switch (language) {
      case 'hindi':
        return word['hindi'] ?? '';
      case 'british':
        return word['british'] ?? '';
      case 'american':
        return word['american'] ?? '';
      default:
        return '';
    }
  }

  String _languageName(String language) {
    switch (language) {
      case 'hindi':
        return 'Hindi 🇮🇳';
      case 'british':
        return 'British 🇬🇧';
      case 'american':
        return 'American 🇺🇸';
      default:
        return language;
    }
  }

  List<String> _possibleAnswerLanguages(
    String question,
  ) {
    if (question == 'hindi') {
      return ['british', 'american'];
    }

    if (question == 'british') {
      return ['hindi', 'american'];
    }

    return ['hindi', 'british'];
  }

  void _createQuestion() {
    if (widget.words.isEmpty) {
      return;
    }

    setState(() {
      answered = false;
      selectedAnswer = '';

      questionLanguage = widget.startingLanguage;

      final possibleLanguages =
          _possibleAnswerLanguages(questionLanguage);

      answerLanguage =
          possibleLanguages[_random.nextInt(
            possibleLanguages.length,
          )];

      currentIndex =
          _random.nextInt(widget.words.length);

      correctAnswer = _getValue(
        currentWord,
        answerLanguage,
      );

      final answerSet = <String>{correctAnswer};

      while (answerSet.length < 4 &&
          answerSet.length < widget.words.length) {
        final randomWord =
            widget.words[_random.nextInt(widget.words.length)];

        final value = _getValue(
          randomWord,
          answerLanguage,
        );

        if (value.isNotEmpty) {
          answerSet.add(value);
        }
      }

      options = answerSet.toList();
      options.shuffle(_random);
    });
  }

  void _selectAnswer(String answer) {
    if (answered) {
      return;
    }

    setState(() {
      answered = true;
      selectedAnswer = answer;
      totalAnswered++;

      if (answer == correctAnswer) {
        score++;
      }
    });
  }

  Color _optionColor(String option) {
    if (!answered) {
      return Colors.white;
    }

    if (option == correctAnswer) {
      return Colors.green.shade100;
    }

    if (option == selectedAnswer) {
      return Colors.red.shade100;
    }

    return Colors.white;
  }

  IconData? _optionIcon(String option) {
    if (!answered) {
      return null;
    }

    if (option == correctAnswer) {
      return Icons.check_circle;
    }

    if (option == selectedAnswer) {
      return Icons.cancel;
    }

    return null;
  }

  void _nextQuestion() {
    _createQuestion();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.words.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Practice'),
        ),
        body: const Center(
          child: Text(
            'No vocabulary words available.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    final question = _getValue(
      currentWord,
      questionLanguage,
    );

    final hindiMeaning = currentWord['hindi'] ?? '';
    final british = currentWord['british'] ?? '';
    final american = currentWord['american'] ?? '';
    final example = currentWord['example'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Score: $score',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Answered: $totalAnswered',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              LinearProgressIndicator(
                value: totalAnswered == 0
                    ? 0
                    : (score / totalAnswered).clamp(0.0, 1.0),
              ),

              const SizedBox(height: 25),

              Text(
                'Translate into ${_languageName(answerLanguage)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 18),

              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      Text(
                        _languageName(questionLanguage),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        question,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.separated(
                  itemCount: options.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final option = options[index];
                    final icon = _optionIcon(option);

                    return SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () =>
                            _selectAnswer(option),
                        style: OutlinedButton.styleFrom(
                          backgroundColor:
                              _optionColor(option),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 17,
                          ),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                option,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (icon != null)
                              Icon(
                                icon,
                                color:
                                    option == correctAnswer
                                        ? Colors.green
                                        : Colors.red,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (answered) ...[
                Card(
                  elevation: 0,
                  color: Colors.indigo.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedAnswer == correctAnswer
                              ? '✅ Correct!'
                              : '❌ Correct answer: $correctAnswer',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Hindi: $hindiMeaning',
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(
                          '🇬🇧 British: $british',
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(
                          '🇺🇸 American: $american',
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Example: $example',
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: _nextQuestion,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text(
                      'Next Question',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
