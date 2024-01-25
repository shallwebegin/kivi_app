import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kivi_app/widgets/lesson_drawer.dart';

final _firebase = FirebaseAuth.instance;

class OgrenciSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Profil Ekranı'),
      ),
      body: FutureBuilder(
        future: _getStudentInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else {
            final studentInfo = snapshot.data as Map<String, dynamic>?;

            if (studentInfo != null) {
              final imageUrl = studentInfo['image_url'] as String?;
              final username = studentInfo['username'] as String?;
              final email = studentInfo['email'] as String?;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    if (imageUrl != null)
                      Image.network(
                        imageUrl,
                        height: 150,
                        width: 150,
                      )
                    else
                      Text('Profil Fotoğrafı Bulunamadı'),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text('Kullanıcı Adı'),
                        subtitle: Text(username ?? '-'),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text('E-posta'),
                        subtitle: Text(email ?? '-'),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('Öğrenci Bilgileri Bulunamadı'));
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
          final studentInfo = docSnapshot.data() as Map<String, dynamic>?;
          return studentInfo;
        }
      }
    } catch (error) {
      print('Öğrenci bilgisi getirme hatası: $error');
    }
    return null;
  }
}
