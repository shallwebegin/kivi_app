import 'package:flutter/material.dart';
import 'package:kivi_app/models/lessons.dart';

class AdminAddLesson extends StatefulWidget {
  const AdminAddLesson({super.key, required this.onLessonSubmitted});
  final void Function(Lesson lesson) onLessonSubmitted;

  @override
  State<AdminAddLesson> createState() => _AdminAddLessonState();
}

class _AdminAddLessonState extends State<AdminAddLesson> {
  final _formKey = GlobalKey<FormState>();
  late String id;
  late String title;
  late String imageUrl;
  late int duration;
  late List<String> question;
  late List<String> answer;
  late List<String> categories;
  late Complexity complexity = Complexity.zor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please check information';
                  }
                  return null;
                },
                onSaved: (value) {
                  id = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Categories'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please check information';
                  }
                  return null;
                },
                onSaved: (value) {
                  categories = value!.split(',');
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please check information';
                  }
                  return null;
                },
                onSaved: (value) {
                  title = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'ImageUrl'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please check information';
                  }
                  return null;
                },
                onSaved: (value) {
                  imageUrl = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Duration'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please check information';
                  }
                  return null;
                },
                onSaved: (value) {
                  duration = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Questions'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please check information';
                  }
                  return null;
                },
                onSaved: (value) {
                  question = value!.split(',');
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Answers'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please check information';
                  }
                  return null;
                },
                onSaved: (value) {
                  answer = value!.split(',');
                },
              ),
              DropdownButtonFormField(
                value: complexity,
                items: Complexity.values
                    .map(
                      (complexity) => DropdownMenuItem(
                        value: complexity,
                        child: Text(complexity.name.toString()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    complexity = value!;
                  });
                },
                onSaved: (value) {
                  complexity = value!;
                },
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final lesson = Lesson(
                            id: id,
                            categories: categories,
                            title: title,
                            imageUrl: imageUrl,
                            question: question,
                            answer: answer,
                            duration: duration,
                            complexity: complexity);
                        widget.onLessonSubmitted(lesson);
                      }
                    },
                    child: const Text('Add Lesson'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
