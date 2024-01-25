enum Complexity {
  simple,
  challenging,
  hard,
}

enum Affordability {
  affordable,
  pricey,
  luxurious,
}

class Ders {
  const Ders({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.sorular,
    required this.cevaplar,
    required this.duration,
    required this.complexity,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> sorular;
  final List<String> cevaplar;
  final int duration;
  final Complexity complexity;

  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
}
