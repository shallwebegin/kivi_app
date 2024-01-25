import 'package:flutter/material.dart';
import 'package:kivi_app/models/category.dart';
import 'package:kivi_app/models/lesson.dart';
import 'package:kivi_app/models/lesson_data.dart';
import 'package:kivi_app/screens/dersler.dart';

import 'package:kivi_app/screens/ogrenci.dart';
import 'package:kivi_app/widgets/category_grid_item.dart';

class AnaSayfaScreen extends StatelessWidget {
  const AnaSayfaScreen({super.key, required this.availableMeals});
  final List<Ders> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          dersler: filteredMeals,
        ),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OgrenciSayfasi(),
                ));
              },
              icon: const Icon(Icons.sensor_occupied_rounded))
        ],
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            Material(
              // Material widget'ını ekledik
              child: CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              ),
            ),
        ],
      ),
    );
  }
}
