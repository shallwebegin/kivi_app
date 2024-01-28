import 'package:flutter/material.dart';
import 'package:kivi_app/models/ders.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:kivi_app/widgets/ders_item_trait.dart';

class DersItem extends StatelessWidget {
  const DersItem({
    super.key,
    required this.ders,
    required this.onSelectMeal,
  });

  final Ders ders;
  final void Function(Ders ders) onSelectMeal;

  String get complexityText {
    return ders.complexity.name[0].toUpperCase() +
        ders.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectMeal(ders);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(ders.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      ders.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // Very long text ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DersItemTrait(
                          icon: Icons.schedule,
                          label: '${ders.duration} min',
                        ),
                        const SizedBox(width: 12),
                        DersItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
