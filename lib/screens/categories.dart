import 'package:flutter/material.dart';
import 'package:kivi_app/data/ders_data.dart';
import 'package:kivi_app/models/ders.dart';
import 'package:kivi_app/models/kategori.dart';

import 'package:kivi_app/widgets/category_grid_item.dart';
import 'package:kivi_app/screens/dersler.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.availableDersler,
  });

  final List<Ders> availableDersler;

  void _selectCategory(BuildContext context, Category category) {
    final filteredDersler = availableDersler
        .where((ders) => ders.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DerslerScreen(
          title: category.title,
          dersler: filteredDersler,
        ),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
          for (final category in mevcutKategoriler)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
    );
  }
}
