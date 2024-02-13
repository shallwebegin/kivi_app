// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kivi_app/screens/admin.dart';

import 'package:kivi_app/screens/tabs.dart';
import 'package:kivi_app/widgets/user_image_picker.dart';

class CredentialScreen extends StatefulWidget {
  const CredentialScreen({super.key});

  @override
  State<CredentialScreen> createState() => _CredentialScreenState();
}

class _CredentialScreenState extends State<CredentialScreen> {
  final _form = GlobalKey<FormState>();
  var isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';

  var isAuthentication = false;
  var isManager = false;
  File? pickedImage;

  void credentialUser() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      setState(() {
        isAuthentication = true;
      });
      if (isLogin) {
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _enteredEmail, password: _enteredPassword);
        if (isManager && !isUserManager(userCredential.user!)) {
          showAlertDialog(
              context, 'Error', 'You do not have administrative authority');
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  isManager ? const AdminScreen() : const TabsScreen(),
            ),
          );
        }
      } else {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _enteredEmail, password: _enteredPassword);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredential.user!.uid}.jpg');
        await storageRef.putFile(
          pickedImage!,
          SettableMetadata(contentType: 'image/jpg'),
        );
        final imageUrl = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
          'image_url': imageUrl,
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use' ||
          error.code == 'wrong-password' ||
          error.code == 'invalid-email') {
        showAlertDialog(context, 'Error', 'Please check your information');
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication Failed'),
        ),
      );
    } finally {
      setState(() {
        isAuthentication = false;
      });
    }
  }

  bool isUserManager(User user) {
    return user.email != null && user.email!.contains('@yonetici.com');
  }

  void showAlertDialog(BuildContext context, String title, String messsage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(messsage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.white],
                ),
              ),
            ),
            Center(
              child: Card(
                margin: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        if (!isLogin)
                          UserImagePicker(
                            onPickImage: (image) {
                              pickedImage = image;
                            },
                          ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Email Address'),
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please check your Email Address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredEmail = value!;
                          },
                        ),
                        if (!isLogin)
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Username'),
                            validator: (value) {
                              if (value == null || value.trim().length < 4) {
                                return 'Please check your Username';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredUsername = value!;
                            },
                          ),
                        TextFormField(
                          obscureText: true,
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Please check your Password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredPassword = value!;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (isAuthentication) const CircularProgressIndicator(),
                        if (!isAuthentication)
                          TextButton(
                            onPressed: credentialUser,
                            child: Text(isLogin ? 'Login' : 'SignUp'),
                          ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(isLogin
                              ? 'Create an Account'
                              : 'I already have an account'),
                        ),
                        if (isLogin)
                          CheckboxListTile(
                            title: const Text('Admin Login'),
                            value: isManager,
                            onChanged: (value) {
                              setState(() {
                                isManager = value!;
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
