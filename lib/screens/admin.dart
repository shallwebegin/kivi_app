import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kivi_app/models/ders.dart';
import 'package:kivi_app/screens/admin_add_lesson.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kivi_app/screens/tabs.dart';

final _firebase = FirebaseAuth.instance;

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = _firebase.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: Center(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey,
              foregroundImage: AssetImage(
                'assets/images/kivi.jpg',
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
            ElevatedButton(
              onPressed: () {
                _showAddDersModal(context);
              },
              child: const Text('Ders Ekle'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDersModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddDersForm(
          onDersSubmitted: (ders) {
            addDersToFirestore(ders).then((_) {
              Navigator.of(context).pop(); // Modal'ı kapat
              Navigator.of(context).push(
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
}
