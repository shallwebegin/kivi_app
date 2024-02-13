enum Complexity {
  kolay,
  orta,
  zor,
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
    this.zor,
    this.orta,
    this.kolay,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> question;
  final List<String> answer;
  final int duration;
  final Complexity complexity;

  final bool? zor;
  final bool? orta;
  final bool? kolay;
}
