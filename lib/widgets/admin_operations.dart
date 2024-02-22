import 'package:flutter/material.dart';
import 'package:kivi_app/models/lessons.dart';

class AdminOperations extends StatefulWidget {
  const AdminOperations({super.key, required this.onLessonSubmitted});
  final void Function(Lesson lesson) onLessonSubmitted;

  @override
  State<AdminOperations> createState() => _AdminOperationsState();
}

class _AdminOperationsState extends State<AdminOperations> {
  final _formKey = GlobalKey<FormState>();
  late String id;
  late String title;
  late String imageUrl;
  late int duration;
  late List<String> question;
  late List<String> answer;
  late List<String> categories;
  late String complexity = Complexity.zor.complexityString;

  late bool zor = false;
  late bool orta = false;
  late bool kolay = false;

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
                decoration: const InputDecoration(labelText: 'Complexity'),
                value: complexity,
                items: Complexity.values
                    .map(
                      (complexity) => DropdownMenuItem(
                        value: complexity.complexityString,
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
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                    labelText: 'Difficulty of the lesson'),
                value: 'Zor',
                items: const [
                  DropdownMenuItem<String>(
                    value: 'Zor',
                    child: Text('Zor'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Orta',
                    child: Text('Orta'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Kolay',
                    child: Text('Kolay'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    if (value == 'Zor') {
                      zor = true;
                      orta = false;
                      kolay = false;
                    } else if (value == 'Orta') {
                      zor = false;
                      orta = true;
                      kolay = false;
                    } else {
                      zor = false;
                      orta = false;
                      kolay = true;
                    }
                  });
                },
                onSaved: (value) {
                  if (value == 'Zor') {
                    zor = true;
                    orta = false;
                    kolay = false;
                  } else if (value == 'Orta') {
                    zor = false;
                    orta = true;
                    kolay = false;
                  } else {
                    zor = false;
                    orta = false;
                    kolay = true;
                  }
                },
              ),
              const SizedBox(
                height: 10,
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
                          complexity: complexity,
                          zor: zor,
                          orta: orta,
                          kolay: kolay,
                        );
                        widget.onLessonSubmitted(lesson);
                      }
                    },
                    child: const Text('Add Lesson'),
                  ),
                  const SizedBox(
                    width: 5,
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
