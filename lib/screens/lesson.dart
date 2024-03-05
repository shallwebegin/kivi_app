import 'package:flutter/material.dart';

import 'package:space_quiz_bank/models/lessons.dart';
import 'package:space_quiz_bank/screens/lesson_detail.dart';
import 'package:space_quiz_bank/widgets/lesson_item.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key, required this.lessons, this.title});
  final List<Lesson> lessons;
  final String? title;

  void pickLesson(BuildContext context, Lesson lesson) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LessonDetailScreen(lesson: lesson),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (context, index) => LessonItem(
        lesson: lessons[index],
        onPickLesson: (lesson) {
          pickLesson(context, lesson);
        },
      ),
    );
    if (lessons.isEmpty) {
      content = const Center(
        child: Text('No found anything'),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
