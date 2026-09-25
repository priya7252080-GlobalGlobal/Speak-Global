enum EnglishVariant {
  british,
  indian,
  american,
  compare,
}

class VocabularyWord {
  final String id;
  final String word;
  final String meaningHindi;
  final String meaningEnglish;
  final String example;
  final String? imageAsset;
  final String britishUsage;
  final String indianUsage;
  final String americanUsage;

  const VocabularyWord({
    required this.id,
    required this.word,
    required this.meaningHindi,
    required this.meaningEnglish,
    required this.example,
    this.imageAsset,
    required this.britishUsage,
    required this.indianUsage,
    required this.americanUsage,
  });
}
