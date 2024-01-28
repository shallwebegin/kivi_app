import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kivi_app/models/ders.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Ders>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleDersFavoriteStatus(Ders ders) {
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

final favoriteDersProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Ders>>((ref) {
  return FavoriteMealsNotifier();
});
