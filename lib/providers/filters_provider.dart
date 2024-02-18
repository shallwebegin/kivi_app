import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kivi_app/providers/lesson_provider.dart';

enum Filters { zor, orta, kolay }

class FilterLessonProvider extends StateNotifier<Map<Filters, bool>> {
  FilterLessonProvider()
      : super({
          Filters.zor: false,
          Filters.orta: false,
          Filters.kolay: false,
        });
  void setFilters(Map<Filters, bool> choosenFilter) {
    state = choosenFilter;
  }

  void setFilter(Filters filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterProvider =
    StateNotifierProvider<FilterLessonProvider, Map<Filters, bool>>(
        (ref) => FilterLessonProvider());
final filteredLessonProvider = Provider((ref) {
  final lesson = ref.watch(lessonProvider);
  final activeFilters = ref.watch(filterProvider);
  return lesson.where((lesson) {
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
