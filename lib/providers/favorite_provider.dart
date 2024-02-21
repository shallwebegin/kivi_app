import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kivi_app/models/lessons.dart';

class FavoriteLessonNotifier extends StateNotifier<List<Lesson>> {
  FavoriteLessonNotifier() : super([]);
  bool toggleLessonFavoriteStatus(Lesson lesson) {
    final lesonIsFavorite = state.contains(lesson);
    if (lesonIsFavorite) {
      state = state.where((l) => l.id != lesson.id).toList();
      return false;
    } else {
      state = [...state, lesson];
      return true;
    }
  }
}

final favoriteProvider =
    StateNotifierProvider<FavoriteLessonNotifier, List<Lesson>>(
        (ref) => FavoriteLessonNotifier());
