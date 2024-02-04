import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kivi_app/providers/lesson_provider.dart';

enum Filter { zor, orta, kolay }

class FilterLessonNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterLessonNotifier()
      : super({
          Filter.zor: false,
          Filter.orta: false,
          Filter.kolay: false,
        });
  void setFilters(Map<Filter, bool> choosenFilter) {
    state = choosenFilter;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FilterLessonNotifier, Map<Filter, bool>>(
        (ref) => FilterLessonNotifier());
final filteredLessonProvider = Provider((ref) {
  final lessons = ref.watch(lessonProvider);
  final activeFilters = ref.watch(filterProvider);
  return lessons.where((ders) {
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
