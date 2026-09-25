import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SentenceBuilderScreen extends StatefulWidget {
  final String sentence;
  final Map<String, String> wordMeanings;

  const SentenceBuilderScreen({
    super.key,
    required this.sentence,
    required this.wordMeanings,
  });

  @override
  State<SentenceBuilderScreen> createState() =>
      _SentenceBuilderScreenState();
}

class _SentenceBuilderScreenState
    extends State<SentenceBuilderScreen> {
  final FlutterTts _tts = FlutterTts();

  final List<String> _selectedWords = [];
  late List<String> _availableWords;

  String? _selectedMeaningWord;
  bool _submitted = false;
  bool? _isCorrect;

  @override
  void initState() {
    super.initState();

    final words = _cleanSentence(
      widget.sentence,
    );

    _availableWords = List<String>.from(words);
    _availableWords.shuffle(Random());
  }

  List<String> _cleanSentence(String sentence) {
    return sentence
        .replaceAll(
          RegExp(r'[.,!?]'),
          '',
        )
        .split(' ')
        .where(
          (word) => word.trim().isNotEmpty,
        )
        .toList();
  }

  String get _correctSentence {
    return _cleanSentence(
      widget.sentence,
    ).join(' ');
  }

  String get _currentSentence {
    return _selectedWords.join(' ');
  }

  void _addWord(String word) {
    if (_submitted) {
      return;
    }

    setState(() {
      _selectedWords.add(word);
      _availableWords.remove(word);
      _selectedMeaningWord = null;
    });
  }

  void _removeWord(String word) {
    if (_submitted) {
      return;
    }

    setState(() {
      _selectedWords.remove(word);
      _availableWords.add(word);
      _selectedMeaningWord = null;
    });
  }

  void _showMeaning(String word) {
    setState(() {
      _selectedMeaningWord = word;
    });
  }

  Future<void> _speakWord(String word) async {
    await _tts.setLanguage('en-IN');
    await _tts.setSpeechRate(0.42);
    await _tts.setPitch(1.0);
    await _tts.speak(word);
  }

  Future<void> _speakSentence() async {
    await _tts.setLanguage('en-IN');
    await _tts.setSpeechRate(0.42);
    await _tts.setPitch(1.0);
    await _tts.speak(_currentSentence);
  }

  void _checkAnswer() {
    if (_selectedWords.isEmpty) {
      return;
    }

    final correct =
        _currentSentence.toLowerCase() ==
            _correctSentence.toLowerCase();

    setState(() {
      _submitted = true;
      _isCorrect = correct;
    });
  }

  void _reset() {
    final words = _cleanSentence(
      widget.sentence,
    );

    setState(() {
      _selectedWords.clear();
      _availableWords =
          List<String>.from(words);
      _availableWords.shuffle(Random());

      _selectedMeaningWord = null;
      _submitted = false;
      _isCorrect = null;
    });
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Build the Sentence',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Make a sentence',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Tap words to arrange them correctly.',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your sentence',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selectedWords
                          .map(
                            (word) => GestureDetector(
                              onTap: () =>
                                  _showMeaning(word),
                              child: Chip(
                                label: Text(
                                  word,
                                  style:
                                      const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                deleteIcon:
                                    const Icon(
                                  Icons.close,
                                  size: 17,
                                ),
                                onDeleted:
                                    _submitted
                                        ? null
                                        : () =>
                                            _removeWord(
                                              word,
                                            ),
                              ),
                            ),
                          )
                          .toList(),
                    ),

                    if (_selectedWords.isEmpty)
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 8),
                        child: Text(
                          'Choose words below...',
                          style: TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              if (_selectedMeaningWord != null)
                Container(
                  padding:
                      const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.indigo
                        .withOpacity(0.08),
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${_selectedMeaningWord!} = '
                          '${widget.wordMeanings[_selectedMeaningWord!] ?? 'Meaning not available'}',
                          style:
                              const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            _speakWord(
                          _selectedMeaningWord!,
                        ),
                        icon: const Icon(
                          Icons.volume_up_rounded,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 18),

              const Text(
                'Words',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _availableWords
                        .map(
                          (word) => ActionChip(
                            label: Text(
                              word,
                              style:
                                  const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            onPressed:
                                _submitted
                                    ? null
                                    : () =>
                                        _addWord(
                                          word,
                                        ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),

              if (_submitted)
                Container(
                  margin:
                      const EdgeInsets.only(
                    bottom: 12,
                  ),
                  padding:
                      const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _isCorrect == true
                        ? Colors.green
                            .withOpacity(0.12)
                        : Colors.red
                            .withOpacity(0.12),
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _isCorrect == true
                              ? 'Correct! 🎉'
                              : 'Not quite. Try again.',
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (_isCorrect == false)
                        TextButton(
                          onPressed: _reset,
                          child:
                              const Text('Retry'),
                        ),
                    ],
                  ),
                ),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed:
                          _currentSentence
                                  .isEmpty
                              ? null
                              : _speakSentence,
                      icon: const Icon(
                        Icons.volume_up,
                      ),
                      label:
                          const Text('Listen'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitted
                          ? _reset
                          : _checkAnswer,
                      child: Text(
                        _submitted
                            ? 'Try Again'
                            : 'Check',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
