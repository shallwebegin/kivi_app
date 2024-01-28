import 'package:flutter/material.dart';
import 'package:kivi_app/models/ders.dart';

import 'package:kivi_app/screens/ders_details.dart';
import 'package:kivi_app/widgets/ders_item.dart';

class DerslerScreen extends StatelessWidget {
  const DerslerScreen({
    super.key,
    this.title,
    required this.dersler,
  });

  final String? title;
  final List<Ders> dersler;

  void selectDers(BuildContext context, Ders ders) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DersDetailsScreen(
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
        itemBuilder: (ctx, index) => DersItem(
          ders: dersler[index],
          onSelectMeal: (ders) {
            selectDers(context, ders);
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
