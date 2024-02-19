import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kivi_app/providers/favorite_provider.dart';

import 'package:kivi_app/providers/filters_provider.dart';
import 'package:kivi_app/screens/categories.dart';
import 'package:kivi_app/screens/credential.dart';
import 'package:kivi_app/screens/filters.dart';
import 'package:kivi_app/screens/lesson.dart';
import 'package:kivi_app/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(
      () {
        _selectedPageIndex = index;
        if (index == 1) {
          final favoriteLesson = ref.watch(favoriteProvider);
          addFavoriteToFirestore(
            FirebaseAuth.instance.currentUser!.uid,
            favoriteLesson.map((lesson) => lesson.id).toList(),
          );
        }
      },
    );
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  Future<void> addFavoriteToFirestore(
    String userId,
    List<String> favoriteLessonIds,
  ) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('favorites').doc(userId).set({
      'email': FirebaseAuth.instance.currentUser!.email,
      'username': FirebaseAuth.instance.currentUser!.displayName,
      'favorites': favoriteLessonIds,
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableLesson = ref.watch(filteredLessonProvider);

    Widget activePage = CategoriesScreen(
      availableLesson: availableLesson,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteLesson = ref.watch(favoriteProvider);
      activePage = LessonScreen(
        lessons: favoriteLesson,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const CredentialScreen(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
