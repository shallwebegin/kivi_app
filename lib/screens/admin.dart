import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kivi_app/widgets/user_image_picker.dart';

final _firebase = FirebaseAuth.instance;

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  File? pickedImage;
  final User? user = _firebase.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserImagePicker(
            onPickImage: (image) {
              pickedImage = image;
            },
          ),
          user != null
              ? Text('Admin Email Address : ${user!.email}')
              : const Text('Admin Email Addres not found'),
        ],
      ),
    );
  }
}
