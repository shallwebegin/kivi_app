import 'package:flutter/material.dart';
import 'package:kivi_app/models/ders.dart';
import 'package:kivi_app/screens/lesson_detail.dart';
import 'package:kivi_app/widgets/lesson_item.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key, required this.dersler, this.title});
  final List<Ders> dersler;
  final String? title;

  void pickLesson(BuildContext context, Ders ders) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LessonDetailScreen(ders: ders),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: dersler.length,
      itemBuilder: (context, index) => LessonItem(
        ders: dersler[index],
        onPickLesson: (ders) {
          pickLesson(context, ders);
        },
      ),
    );
    if (dersler.isEmpty) {
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
