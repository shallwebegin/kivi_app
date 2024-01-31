import 'package:flutter/material.dart';
import 'package:kivi_app/models/ders.dart';
import 'package:kivi_app/widgets/lesson_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class LessonItem extends StatelessWidget {
  const LessonItem({super.key, required this.ders});
  final Ders ders;

  String get complexityText {
    return ders.complexity.name[0].toUpperCase() +
        ders.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(ders.imageUrl),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(ders.title),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LessonItemTrait(
                            icon: Icons.watch, label: '${ders.duration} min'),
                        LessonItemTrait(
                            icon: Icons.fitness_center, label: complexityText),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
