import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kivi_app/providers/meals_provider.dart';

enum Filter {
  zor,
  orta,
  kolay,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.zor: false,
          Filter.orta: false,
          Filter.kolay: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; // not allowed! => mutating state
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredDersProvider = Provider((ref) {
  final dersler = ref.watch(derslerProvider);
  final activeFilters = ref.watch(filtersProvider);

  return dersler.where((ders) {
    if (activeFilters[Filter.zor]! && !ders.zor) {
      return false;
    }
    if (activeFilters[Filter.orta]! && !ders.orta) {
      return false;
    }
    if (activeFilters[Filter.kolay]! && !ders.kolay) {
      return false;
    }

    return true;
  }).toList();
});
