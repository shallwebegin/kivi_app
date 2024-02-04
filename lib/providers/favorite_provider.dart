import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kivi_app/models/ders.dart';

class FavoriteLessonNotifier extends StateNotifier<List<Ders>> {
  FavoriteLessonNotifier() : super([]);
  bool toggleLessonFavoriteStatus(Ders ders) {
    final dersIsFavorite = state.contains(ders);
    if (dersIsFavorite) {
      state = state.where((d) => d.id != ders.id).toList();
      return false;
    } else {
      state = [...state, ders];
      return true;
    }
  }
}

final favoriteProvider =
    StateNotifierProvider<FavoriteLessonNotifier, List<Ders>>(
        (ref) => FavoriteLessonNotifier());
