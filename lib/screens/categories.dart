// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kivi_app/data/category_data.dart';

import 'package:kivi_app/models/lessons.dart';
import 'package:kivi_app/providers/filters_provider.dart';

import 'package:kivi_app/screens/lesson.dart';
import 'package:kivi_app/widgets/category_grid_item.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableLesson,
  });

  final List<Lesson> availableLesson;

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('lessons').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              final documents = snapshot.data!.docs;
              final firebaseLessonList = documents.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return Lesson(
                  id: data['id'],
                  title: data['title'],
                  imageUrl: data['imageUrl'],
                  duration: data['duration'],
                  complexity: data['complexity'].toString(),
                  question: List<String>.from(data['question']),
                  answer: List<String>.from(data['answer']),
                  categories: List<String>.from(data['categories']),
                  zor: data['zor'],
                  orta: data['orta'],
                  kolay: data['kolay'],
                );
              }).toList();

              return GridView(
                padding: const EdgeInsets.only(top: 120),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: [
                  for (final category in availableCategories)
                    CategoryGridItem(
                      category: category,
                      onSelectCategory: () {
                        final firebaseLessonList =
                            ref.watch(filteredLessonProvider);
                        final filteredLesson = firebaseLessonList
                            .where((lesson) =>
                                lesson.categories.contains(category.id))
                            .toList();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LessonScreen(
                              lessons: filteredLesson,
                              title: category.title,
                            ),
                          ),
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
