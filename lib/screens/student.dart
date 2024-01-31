import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class StudentPage extends StatelessWidget {
  const StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getStudentInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final studentInfo = snapshot.data;
            if (studentInfo != null) {
              final userName = studentInfo['username'] as String;
              final email = studentInfo['email'] as String;
              final imageUrl = studentInfo['image_url'] as String;
              return Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  children: [
                    if (imageUrl.isNotEmpty) Image.network(imageUrl),
                    Card(
                      child: ListTile(
                        title: const Text('Kullanici Adi : '),
                        subtitle: Text(userName),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: const Text('Email Addres : '),
                        subtitle: Text(email),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('Kullanici Bilgileri Bulunamadi');
            }
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>?> _getStudentInfo() async {
    try {
      final user = _firebase.currentUser;
      if (user != null) {
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (docSnapshot.exists) {
          final studentInfo = docSnapshot.data();
          return studentInfo;
        }
      }
    } catch (error) {
      const Dialog(
        child: Text('Kullanici Bulunamadi'),
      );
    }
    return null;
  }
}
