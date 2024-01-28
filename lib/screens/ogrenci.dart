import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kivi_app/screens/tabs.dart';

final _firebase = FirebaseAuth.instance;

class OgrenciSayfasi extends StatefulWidget {
  const OgrenciSayfasi({super.key});

  @override
  State<OgrenciSayfasi> createState() => _OgrenciSayfasiState();
}

class _OgrenciSayfasiState extends State<OgrenciSayfasi> {
  void _setScreen(String identifier) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Ekranı'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TabsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: FutureBuilder(
        future: _getStudentInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
                      const Text('Profil Fotoğrafı Bulunamadı'),
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: const Text('Kullanıcı Adı'),
                        subtitle: Text(username ?? '-'),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: const Text('E-posta'),
                        subtitle: Text(email ?? '-'),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Öğrenci Bilgileri Bulunamadı'));
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
