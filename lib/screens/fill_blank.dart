import 'package:flutter/material.dart';

class FillBlankScreen extends StatefulWidget {
  final String word;
  final String sentence;
  final String answer;
  final String hindiMeaning;

  const FillBlankScreen({
    super.key,
    required this.word,
    required this.sentence,
    required this.answer,
    required this.hindiMeaning,
  });

  @override
  State<FillBlankScreen> createState() =>
      _FillBlankScreenState();
}

class _FillBlankScreenState
    extends State<FillBlankScreen> {
  final TextEditingController _controller =
      TextEditingController();

  bool _checked = false;
  bool _correct = false;

  void _checkAnswer() {
    final userAnswer =
        _controller.text.trim().toLowerCase();

    final correctAnswer =
        widget.answer.trim().toLowerCase();

    setState(() {
      _checked = true;
      _correct = userAnswer == correctAnswer;
    });
  }

  void _tryAgain() {
    setState(() {
      _controller.clear();
      _checked = false;
      _correct = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displaySentence =
        widget.sentence.replaceFirst(
      '___',
      '______',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fill in the Blank',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Complete the sentence',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Word: ${widget.word}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                padding:
                    const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text(
                  displaySentence,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: _controller,
                enabled: !_checked,
                textInputAction:
                    TextInputAction.done,
                decoration: InputDecoration(
                  hintText:
                      'Type the missing word',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                  prefixIcon: const Icon(
                    Icons.edit,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              if (_checked)
                Container(
                  padding:
                      const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _correct
                        ? Colors.green
                            .withOpacity(0.12)
                        : Colors.red
                            .withOpacity(0.12),
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        _correct
                            ? 'Correct! 🎉 +10 points'
                            : 'Not quite.',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.bold,
                          color: _correct
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Correct answer: '
                        '${widget.answer}',
                        style:
                            const TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Meaning: '
                        '${widget.hindiMeaning}',
                        style:
                            const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

              const Spacer(),

              ElevatedButton(
                onPressed:
                    _checked ? _tryAgain : _checkAnswer,
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      const Size.fromHeight(54),
                ),
                child: Text(
                  _checked
                      ? 'Try Again'
                      : 'Check Answer',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
