// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kivi_app/models/ders.dart';
import 'package:kivi_app/screens/admin_add_lesson.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kivi_app/screens/credential.dart';
import 'package:kivi_app/screens/tabs.dart';
import 'package:kivi_app/widgets/student_list.dart';

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
      body: Center(
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showAddDersModal(context);
                    },
                    child: const Text('Ders Ekle'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showDeleteDersModal(context);
                    },
                    child: const Text('Ders Sil'),
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
                    child: const Text('Ogrenci Sil'),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddDersModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          // Sayfanın tamamını kaplar

          child: AddDersForm(
            onDersSubmitted: (ders) {
              addDersToFirestore(ders).then((_) {
                Navigator.of(context).pop(); // Modal'ı kapat
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const TabsScreen()),
                );
              }).catchError((error) {
                // Hata durumunda kullanıcıya bilgi verilebilir
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

  Future<void> addDersToFirestore(Ders ders) {
    return FirebaseFirestore.instance.collection('dersler').add({
      'id': ders.id,
      'categories': ders.categories,
      'title': ders.title,
      'imageUrl': ders.imageUrl,
      'sorular': ders.sorular,
      'cevaplar': ders.cevaplar,
      'duration': ders.duration,
      'complexity': ders.complexity.toString(),
      'zor': ders.zor,
      'orta': ders.orta,
      'kolay': ders.kolay,
    });
  }

  void _showDeleteDersModal(BuildContext context) {
    String dersTitle = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ders Sil'),
          content: TextField(
            onChanged: (value) {
              dersTitle = value;
            },
            decoration: const InputDecoration(hintText: 'Ders Adı'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                _deleteDers(dersTitle, context);
                Navigator.of(context).pop();
              },
              child: const Text('Sil'),
            ),
          ],
        );
      },
    );
  }

  void _deleteDers(String dersTitle, BuildContext context) async {
    try {
      // Firestore'da dersleri sorgula
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('dersler')
          .where('title', isEqualTo: dersTitle)
          .get();

      // Ders belgesini bul ve sil
      if (querySnapshot.docs.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('dersler')
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
