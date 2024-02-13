import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kivi_app/providers/lesson_provider.dart';

enum Filters { zor, orta, kolay }

class FilterLessonNotifier extends StateNotifier<Map<Filters, bool>> {
  FilterLessonNotifier()
      : super({
          Filters.zor: false,
          Filters.orta: false,
          Filters.kolay: false,
        });
  void setFilters(Map<Filters, bool> choosenFilter) {
    state = choosenFilter;
  }

  void setFilter(Filters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FilterLessonNotifier, Map<Filters, bool>>(
        (ref) => FilterLessonNotifier());
final filteredLessonProvider = Provider((ref) {
  final lessons = ref.watch(lessonProvider);
  final activeFilters = ref.watch(filterProvider);
  return lessons.where((lesson) {
    if (activeFilters[Filters.zor]! && !lesson.zor!) {
      return false;
    }
    if (activeFilters[Filters.orta]! && !lesson.orta!) {
      return false;
    }
    if (activeFilters[Filters.kolay]! && !lesson.kolay!) {
      return false;
    }
    return true;
  }).toList();
});
