import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kivi_app/screens/uyelik.dart';

import 'package:kivi_app/widgets/kullanici_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class YoneticiSayfasi extends StatefulWidget {
  const YoneticiSayfasi({super.key});

  @override
  State<YoneticiSayfasi> createState() => _YoneticiSayfasiState();
}

class _YoneticiSayfasiState extends State<YoneticiSayfasi> {
  @override
  Widget build(BuildContext context) {
    final User? user = _firebase.currentUser;
    File? secilmisFotograf;
    return Scaffold(
      appBar: AppBar(
        title: const Text('KiviApp'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UyelikEkrani(),
                ));
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserImagePicker(
                onSelectedImage: (image) {
                  secilmisFotograf = image;
                },
              ),
              user != null
                  ? Text(
                      'Kullanıcı E-Posta Adresi: ${user.email}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    )
                  : const Text('Kullanıcı bulunamadı.'),
            ],
          ),
        ),
      ),
    );
  }
}
