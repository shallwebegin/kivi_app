enum Complexity {
  kolay,
  orta,
  zor,
}

extension ComplexityStringExtension on Complexity {
  String get complexityString {
    switch (this) {
      case Complexity.kolay:
        return 'kolay';
      case Complexity.orta:
        return 'orta';
      case Complexity.zor:
        return 'zor';
    }
  }
}

class Lesson {
  const Lesson({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.question,
    required this.answer,
    required this.duration,
    required this.complexity,
    required this.zor,
    required this.orta,
    required this.kolay,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> question;
  final List<String> answer;
  final int duration;
  final String complexity;
  final bool zor;
  final bool orta;
  final bool kolay;
}
