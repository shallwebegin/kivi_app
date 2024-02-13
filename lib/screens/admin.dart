// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kivi_app/models/lessons.dart';
import 'package:kivi_app/screens/credential.dart';

import 'package:kivi_app/widgets/admin_add_lesson.dart';
import 'package:kivi_app/widgets/all_users_screen.dart';

final _firebase = FirebaseAuth.instance;

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = _firebase.currentUser;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Admin Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const CredentialScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey,
                  foregroundImage: AssetImage(
                    'assets/images/pngegg.png',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                user != null
                    ? Text(
                        'Admin Email Address : ${user.email}',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      )
                    : const Text('Admin Email Address not Found'),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  height: 250,
                  width: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Admin Operations',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Icon(
                        Icons.admin_panel_settings,
                        size: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showAddLessonModal(context);
                            },
                            child: const Text('Add Lesson'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showDeleteLessonModal(context);
                            },
                            child: const Text('Delete Lesson'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const AllUsersScreen(),
                                ),
                              );
                            },
                            child: const Text('Delete User'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addLessonToFirestore(Lesson lesson) {
    return FirebaseFirestore.instance.collection('lessons').add({
      'id': lesson.id,
      'categories': lesson.categories,
      'title': lesson.title,
      'imageUrl': lesson.imageUrl,
      'sorular': lesson.question,
      'cevaplar': lesson.answer,
      'duration': lesson.duration,
      'complexity': lesson.complexity.toString(),
      'zor': lesson.zor,
      'orta': lesson.orta,
      'kolay': lesson.kolay,
    });
  }

  void _showAddLessonModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: AdminAddLesson(
            onLessonSubmitted: (lesson) {
              addLessonToFirestore(lesson).then((_) {
                Navigator.of(context).pop();
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ders eklenirken hata oluştu: $error'),
                    backgroundColor: Colors.red,
                  ),
                );
              });
            },
          ),
        );
      },
    );
  }

  void _showDeleteLessonModal(BuildContext context) {
    String lessonTitle = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Lesson'),
          content: TextField(
            onChanged: (value) {
              lessonTitle = value;
            },
            decoration: const InputDecoration(hintText: 'Lesson Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteLesson(lessonTitle, context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteLesson(String lessonTitle, BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('lessons')
          .where('title', isEqualTo: lessonTitle)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('lessons')
            .doc(querySnapshot.docs.first.id)
            .delete();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ders başarıyla silindi.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Belirtilen isme sahip ders bulunamadı.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ders silinirken hata oluştu.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
