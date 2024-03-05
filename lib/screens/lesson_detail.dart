import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_quiz_bank/models/lessons.dart';

import 'package:space_quiz_bank/providers/favorite_provider.dart';

class LessonDetailScreen extends ConsumerWidget {
  const LessonDetailScreen({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteLessons = ref.watch(favoriteProvider);

    final isFavorite = favoriteLessons.contains(lesson);

    return Scaffold(
      appBar: AppBar(title: Text(lesson.title), actions: [
        IconButton(
          onPressed: () {
            final wasAdded = ref
                .read(favoriteProvider.notifier)
                .toggleLessonFavoriteStatus(lesson);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(wasAdded
                    ? 'Lesson added as a favorite.'
                    : 'Lesson removed.'),
              ),
            );
          },
          icon: Icon(isFavorite ? Icons.star : Icons.star_border),
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              lesson.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 14),
            Text(
              'Sorular',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            for (final question in lesson.question)
              Text(
                textAlign: TextAlign.center,
                softWrap: true,
                question,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(height: 24),
            Text(
              'Cevaplar',
              textAlign: TextAlign.center,
              softWrap: true,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            for (final answer in lesson.answer)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  answer,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
