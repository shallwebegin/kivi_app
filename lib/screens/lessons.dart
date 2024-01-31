import 'package:flutter/material.dart';
import 'package:kivi_app/models/ders.dart';
import 'package:kivi_app/widgets/lesson_item.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key, required this.dersler, required this.title});

  final List<Ders> dersler;
  final String title;

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('Uh nothing anything'),
    );
    if (dersler.isNotEmpty) {
      content = ListView.builder(
        itemCount: dersler.length,
        itemBuilder: (context, index) => LessonItem(ders: dersler[index]),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: content);
  }
}
