import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:space_quiz_bank/models/lessons.dart';

class LessonNotifier extends StateNotifier<List<Lesson>> {
  LessonNotifier() : super([]) {
    fetchLessonsFromFirestore();
  }
  Future<void> fetchLessonsFromFirestore() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('lessons').get();
      List<Lesson> lessons = snapshot.docs
          .map((doc) => Lesson(
                id: doc['id'],
                categories: List<String>.from(doc['categories']),
                title: doc['title'],
                imageUrl: doc['imageUrl'],
                duration: doc['duration'],
                complexity: doc['complexity'].toString(),
                question: List<String>.from(doc['question']),
                answer: List<String>.from(doc['answer']),
                zor: doc['zor'],
                orta: doc['orta'],
                kolay: doc['kolay'],
              ))
          .toList();

      state = [...state, ...lessons];
    } catch (error) {
      Text('Error fetching lessons: $error');
    }
  }
}

final lessonNotifierProvider =
    StateNotifierProvider<LessonNotifier, List<Lesson>>(
        (ref) => LessonNotifier());
