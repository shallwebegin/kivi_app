import 'package:flutter/material.dart';
import 'package:kivi_app/data/ders_data.dart';
import 'package:kivi_app/models/ders.dart';
import 'package:kivi_app/models/kategori.dart';
import 'package:kivi_app/screens/lessons.dart';
import 'package:kivi_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.mevcutDersler});

  final List<Ders> mevcutDersler;
  void _selectCategory(BuildContext context, Category category) {
    final filteredLesson = dersKonulari
        .where((ders) => ders.categories.contains(category.id))
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
      body: Material(
        child: GridView(
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
                  _selectCategory(context, category);
                },
              )
          ],
        ),
      ),
    );
  }
}
