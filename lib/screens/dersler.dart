import 'package:flutter/material.dart';
import 'package:kivi_app/models/lesson.dart';
import 'package:kivi_app/screens/ders_detay.dart';
import 'package:kivi_app/widgets/ders_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.dersler,
  });

  final String? title;
  final List<Ders> dersler;

  void selectMeal(BuildContext context, Ders ders) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          ders: ders,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (dersler.isNotEmpty) {
      content = ListView.builder(
        itemCount: dersler.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: dersler[index],
          onSelectMeal: (ders) {
            selectMeal(context, ders);
          },
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
