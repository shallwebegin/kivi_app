import 'package:flutter/material.dart';
import 'package:kivi_app/models/ders.dart';
import 'package:kivi_app/widgets/lesson_item.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key, required this.title, required this.dersler});
  final List<Ders> dersler;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: dersler.length,
        itemBuilder: (context, index) => LessonItem(ders: dersler[index]),
      ),
    );
  }
}
