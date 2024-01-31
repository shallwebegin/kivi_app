import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kivi_app/widgets/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class AdminastorPage extends StatefulWidget {
  const AdminastorPage({super.key});

  @override
  State<AdminastorPage> createState() => _AdminastorPageState();
}

class _AdminastorPageState extends State<AdminastorPage> {
  File? pickedImage;
  final User? user = _firebase.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              UserImagePicker(
                onPickImage: (image) {
                  pickedImage = image;
                },
              ),
              user != null
                  ? Text('Yönetici mail adresi : ${user!.email}')
                  : const Text('Yönetici Bilgileri Bulunamadi')
            ],
          ),
        ),
      ),
    );
  }
}
