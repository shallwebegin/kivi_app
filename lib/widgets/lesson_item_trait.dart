import 'package:flutter/material.dart';

class LessonItemTrait extends StatelessWidget {
  const LessonItemTrait({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Icon(icon), Text(label)],
    );
  }
}
