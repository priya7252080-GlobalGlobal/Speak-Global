import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const SpeakGlobalApp());
}

enum EnglishVariant {
  british,
  indian,
  american,
  compare,
}

class Word {
  final String word;
  final String hindi;
  final String example;
  final String british;
  final String indian;
  final String american;

  const Word({
    required this.word,
    required this.hindi,
    required this.example,
    required this.british,
    required this.indian,
    required this.american,
  });
}

const List<Word> words = [
  Word(
    word: 'Colour',
    hindi: 'रंग',
    example: 'My favourite colour is blue.',
    british: 'colour',
    indian: 'colour',
    american: 'color',
  ),
  Word(
    word: 'Favourite',
    hindi: 'पसंदीदा',
    example: 'This is my favourite book.',
    british: 'favourite',
    indian: 'favourite',
    american: 'favorite',
  ),
  Word(
    word: 'Centre',
    hindi: 'केंद्र',
    example: 'The shop is in the city centre.',
    british: 'city centre',
    indian: 'city centre',
    american: 'city center',
  ),
  Word(
    word: 'Prepone',
    hindi: 'समय पहले करना',
    example: 'Can we prepone the meeting?',
    british: 'Not standard common usage',
    indian: 'Common Indian English usage',
    american: 'Move up / reschedule earlier',
  ),
  Word(
    word: 'Lift',
    hindi: 'लिफ्ट',
    example: 'Take the lift to the third floor.',
    british: 'lift',
    indian: 'lift',
    american: 'elevator',
  ),
  Word(
    word: 'Apartment',
    hindi: 'फ्लैट / अपार्टमेंट',
    example: 'She lives in a new apartment.',
    british: 'flat',
    indian: 'flat / apartment',
    american: 'apartment',
  ),
  Word(
    word: 'Biscuit',
    hindi: 'बिस्कुट',
    example: 'I had a biscuit with tea.',
    british: 'biscuit',
    indian: 'biscuit',
    american: 'cookie',
  ),
  Word(
    word: 'Petrol',
    hindi: 'पेट्रोल',
    example: 'We need to buy petrol.',
    british: 'petrol',
    indian: 'petrol',
    american: 'gas / gasoline',
  ),
  Word(
    word: 'Holiday',
    hindi: 'छुट्टी',
    example: 'We are going on holiday.',
    british: 'holiday',
    indian: 'holiday',
    american: 'vacation',
  ),
  Word(
    word: 'Queue',
    hindi: 'कतार',
    example: 'Please stand in the queue.',
    british: 'queue',
    indian: 'queue',
    american: 'line',
  ),
];

class SpeakGlobalApp extends StatelessWidget {
  const SpeakGlobalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speak Global',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      ),
      home: const LanguageSelectionScreen(),
    );
  }
}

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  void _openLearn(BuildContext context, EnglishVariant variant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LearnScreen(variant: variant),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                'SPEAK GLOBAL',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Learn words. Understand meaning. Speak better.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 45),
              const Text(
                'Choose English',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              _LanguageCard(
                flag: '🇬🇧',
                title: 'British English',
                subtitle: 'British vocabulary & pronunciation',
                onTap: () => _openLearn(
                  context,
                  EnglishVariant.british,
                ),
              ),
              const SizedBox(height: 14),
              _LanguageCard(
                flag: '🇮🇳',
                title: 'Indian English',
                subtitle: 'Indian vocabulary & usage',
                onTap: () => _openLearn(
                  context,
                  EnglishVariant.indian,
                ),
              ),
              const SizedBox(height: 14),
              _LanguageCard(
                flag: '🇺🇸',
                title: 'American English',
                subtitle: 'American vocabulary & pronunciation',
                onTap: () => _openLearn(
                  context,
                  EnglishVariant.american,
                ),
              ),
              const SizedBox(height: 14),
              _LanguageCard(
                flag: '🔄',
                title: 'Compare All Three',
                subtitle: 'British • Indian • American',
                onTap: () => _openLearn(
                  context,
                  EnglishVariant.compare,
                ),
              ),
              const Spacer(),
              const Text(
                'Speak Global • Vocabulary Learning',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String flag;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.flag,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 78,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class LearnScreen extends StatefulWidget {
  final EnglishVariant variant;

  const LearnScreen({
    super.key,
    required this.variant,
  });

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final FlutterTts _tts = FlutterTts();

  int index = 0;

  Word get currentWord => words[index];

  String get languageName {
    switch (widget.variant) {
      case EnglishVariant.british:
        return 'British English 🇬🇧';
      case EnglishVariant.indian:
        return 'Indian English 🇮🇳';
      case EnglishVariant.american:
        return 'American English 🇺🇸';
      case EnglishVariant.compare:
        return 'Compare English 🔄';
    }
  }

  String get languageCode {
    switch (widget.variant) {
      case EnglishVariant.british:
        return 'en-GB';
      case EnglishVariant.indian:
        return 'en-IN';
      case EnglishVariant.american:
      case EnglishVariant.compare:
        return 'en-US';
    }
  }

  Future<void> _speak() async {
    await _tts.setLanguage(languageCode);
    await _tts.setSpeechRate(0.42);
    await _tts.setPitch(1.0);
    await _tts.speak(currentWord.word);
  }

  void _nextWord() {
    setState(() {
      if (index < words.length - 1) {
        index++;
      } else {
        index = 0;
      }
    });
  }

  String _usageText() {
    switch (widget.variant) {
      case EnglishVariant.british:
        return currentWord.british;
      case EnglishVariant.indian:
        return currentWord.indian;
      case EnglishVariant.american:
        return currentWord.american;
      case EnglishVariant.compare:
        return '🇬🇧 ${currentWord.british}\n'
            '🇮🇳 ${currentWord.indian}\n'
            '🇺🇸 ${currentWord.american}';
    }
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
        title: Text(languageName),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Word ${index + 1} of ${words.length}',
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text(
                            currentWord.word,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentWord.hindi,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 18),
                          IconButton(
                            onPressed: _speak,
                            icon: const Icon(
                              Icons.volume_up_rounded,
                              size: 42,
                            ),
                            tooltip: 'Listen',
                          ),
                          const SizedBox(height: 18),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Example',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              currentWord.example,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Usage',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _usageText(),
                              style: const TextStyle(
                                fontSize: 15,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _nextWord,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text(
                    'Next Word',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'data/vocabulary_data.dart';
import 'screens/practice.dart';

void main() {
  runApp(const SpeakGlobalApp());
}

class SpeakGlobalApp extends StatelessWidget {
  const SpeakGlobalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speak Global',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      ),
      home: const LanguageSelectionScreen(),
    );
  }
}

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  void _openLearn(
    BuildContext context,
    String language,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LearnScreen(
          language: language,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              const SizedBox(height: 30),

              const Text(
                'SPEAK GLOBAL',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Learn words. Understand meaning. Speak better.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 45),

              const Text(
                'Choose English',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              _LanguageCard(
                flag: '🇬🇧',
                title: 'British English',
                subtitle: 'British vocabulary & usage',
                onTap: () => _openLearn(
                  context,
                  'british',
                ),
              ),

              const SizedBox(height: 14),

              _LanguageCard(
                flag: '🇮🇳',
                title: 'Indian English',
                subtitle: 'Indian vocabulary & usage',
                onTap: () => _openLearn(
                  context,
                  'indian',
                ),
              ),

              const SizedBox(height: 14),

              _LanguageCard(
                flag: '🇺🇸',
                title: 'American English',
                subtitle: 'American vocabulary & usage',
                onTap: () => _openLearn(
                  context,
                  'american',
                ),
              ),

              const SizedBox(height: 14),

              _LanguageCard(
                flag: '🔄',
                title: 'Compare All Three',
                subtitle: 'British • Indian • American',
                onTap: () => _openLearn(
                  context,
                  'compare',
                ),
              ),

              const Spacer(),

              const Text(
                'Speak Global • Vocabulary Learning',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String flag;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.flag,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 78,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              flag,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class LearnScreen extends StatefulWidget {
  final String language;

  const LearnScreen({
    super.key,
    required this.language,
  });

  @override
  State<LearnScreen> createState() =>
      _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final FlutterTts _tts = FlutterTts();

  int index = 0;

  Map<String, String> get word =>
      vocabularyData[index];

  String get languageTitle {
    switch (widget.language) {
      case 'british':
        return 'British English 🇬🇧';
      case 'indian':
        return 'Indian English 🇮🇳';
      case 'american':
        return 'American English 🇺🇸';
      default:
        return 'Compare English 🔄';
    }
  }

  String _wordToShow() {
    if (widget.language == 'indian') {
      return word['indian'] ?? '';
    }

    if (widget.language == 'american') {
      return word['american'] ?? '';
    }

    if (widget.language == 'british') {
      return word['british'] ?? '';
    }

    return word['word'] ?? '';
  }

  String _speechLanguage() {
    switch (widget.language) {
      case 'british':
        return 'en-GB';
      case 'indian':
        return 'en-IN';
      case 'american':
      default:
        return 'en-US';
    }
  }

  Future<void> _speak() async {
    await _tts.setLanguage(_speechLanguage());
    await _tts.setSpeechRate(0.42);
    await _tts.setPitch(1.0);
    await _tts.speak(_wordToShow());
  }

  void _nextWord() {
    setState(() {
      if (index < vocabularyData.length - 1) {
        index++;
      } else {
        index = 0;
      }
    });
  }

  void _openPractice() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PracticeScreen(
          words: vocabularyData,
          startingLanguage:
              widget.language == 'compare'
                  ? 'hindi'
                  : widget.language,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hindi = word['hindi'] ?? '';
    final british = word['british'] ?? '';
    final indian = word['indian'] ?? '';
    final american = word['american'] ?? '';
    final example = word['example'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(languageTitle),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Text(
                'Word ${index + 1} of ${vocabularyData.length}',
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 15),

              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text(
                            _wordToShow(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            hindi,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 12),

                          IconButton(
                            onPressed: _speak,
                            icon: const Icon(
                              Icons.volume_up_rounded,
                              size: 44,
                            ),
                          ),

                          const SizedBox(height: 15),

                          _InfoRow(
                            title: '🇬🇧 British',
                            value: british,
                          ),

                          _InfoRow(
                            title: '🇮🇳 Indian',
                            value: indian,
                          ),

                          _InfoRow(
                            title: '🇺🇸 American',
                            value: american,
                          ),

                          const SizedBox(height: 15),

                          const Align(
                            alignment:
                                Alignment.centerLeft,
                            child: Text(
                              'Example',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          Align(
                            alignment:
                                Alignment.centerLeft,
                            child: Text(
                              example,
                              style: const TextStyle(
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _openPractice,
                      icon: const Icon(
                        Icons.quiz_outlined,
                      ),
                      label: const Text(
                        'Practice',
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _nextWord,
                      icon: const Icon(
                        Icons.arrow_forward,
                      ),
                      label: const Text(
                        'Next Word',
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

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
