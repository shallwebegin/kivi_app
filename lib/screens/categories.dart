import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kivi_app/data/ders_data.dart';
import 'package:kivi_app/models/ders.dart';

import 'package:kivi_app/screens/lesson.dart';
import 'package:kivi_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.availableLesson,
  });

  final List<Ders> availableLesson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Opacity(
            opacity: 0,
            child: Image.asset(
              'assets/images/kivi.jpg',
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('dersler').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Bir hata oluştu: ${snapshot.error}'),
                );
              }

              final documents = snapshot.data!.docs;
              final firebaseLessonList = documents.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return Ders(
                  id: data['id'],
                  title: data['title'],
                  imageUrl: data['imageUrl'],
                  duration: data['duration'],
                  complexity: Complexity.zor,
                  sorular: List<String>.from(data['sorular']),
                  cevaplar: List<String>.from(data['cevaplar']),
                  zor: data['zor'],
                  orta: data['orta'],
                  kolay: data['kolay'],
                  categories: List<String>.from(data['categories']),
                );
              }).toList();

              final mergedLessonList = [
                ...availableLesson,
                ...firebaseLessonList
              ];

              return GridView(
                padding: const EdgeInsets.only(top: 120),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: [
                  for (final category in mevcutKategoriler)
                    CategoryGridItem(
                      category: category,
                      onSelectCategory: () {
                        final filteredLesson = mergedLessonList
                            .where(
                                (ders) => ders.categories.contains(category.id))
                            .toList();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LessonScreen(
                              dersler: filteredLesson,
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
