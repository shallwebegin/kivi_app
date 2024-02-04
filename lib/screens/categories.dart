import 'package:flutter/material.dart';
import 'package:kivi_app/data/ders_data.dart';
import 'package:kivi_app/models/ders.dart';
import 'package:kivi_app/models/kategori.dart';
import 'package:kivi_app/screens/lesson.dart';

import 'package:kivi_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableLesson});
  final List<Ders> availableLesson;
  void selectCategory(BuildContext context, Category category) {
    final filteredLesson = dersKonulari
        .where(
          (ders) => ders.categories.contains(category.id),
        )
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            LessonScreen(dersler: filteredLesson, title: category.title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Image.asset(
              'assets/images/kivi.jpg',
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          GridView(
            padding: const EdgeInsets.only(top: 120),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            children: [
              for (final category in mevcutKategoriler)
                CategoryGridItem(
                  category: category,
                  onSelectCategory: () {
                    selectCategory(context, category);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
