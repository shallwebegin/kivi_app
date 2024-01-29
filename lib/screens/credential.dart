// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kivi_app/screens/ogrenci.dart';
import 'package:kivi_app/screens/yonetici.dart';
import 'package:kivi_app/widgets/user_image_picker.dart';

class CredentialScreen extends StatefulWidget {
  const CredentialScreen({super.key});

  @override
  State<CredentialScreen> createState() => _CredentialScreenState();
}

class _CredentialScreenState extends State<CredentialScreen> {
  var isLogin = true;
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  var isManager = false;
  var isAuthentication = false;
  File? _pickedImage;
  void kullaniciIslemleri() async {
    final isValid = _form.currentState!.validate();
    if (!isValid || !isLogin && _pickedImage == null) {
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Giriş Başarılı'),
            duration: Duration(seconds: 2),
          ),
        );
        if (isManager && !isUserManager(userCredential.user!)) {
          return showAlertDialog(
              context, 'Hata', 'Yonetici Yetkisine Sahip Degilsiniz');
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  isManager ? const YoneticiScreen() : const OgrenciScreen(),
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
          _pickedImage!,
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Üyelik Başarılı'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use' ||
          error.code == 'invalid-email' ||
          error.code == 'wrong-password') {
        return showAlertDialog(
            context, 'Hata', 'Lütfen Bilgilerinizi Kontrol Ediniz');
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
    return user.email != null && user.email!.contains('@yonetici');
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.only(
                      bottom: 30, top: 20, left: 20, right: 20),
                  child: Image.asset('assets/images/Group.png'),
                ),
              ),
              Card(
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
                              _pickedImage = image;
                            },
                          ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Email Address'),
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Lütfen Düzgün bir email adresi giriniz';
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
                                return 'Lütfen Düzgün bir username giriniz';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredUsername = value!;
                            },
                          ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Lütfen Düzgün bir password giriniz';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredPassword = value!;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (isAuthentication) const CircularProgressIndicator(),
                        if (!isAuthentication)
                          ElevatedButton(
                            onPressed: kullaniciIslemleri,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            child: Text(isLogin ? 'Login' : 'SignUp'),
                          ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(isLogin
                              ? 'Create an account'
                              : 'I already have an account'),
                        ),
                        if (isLogin)
                          CheckboxListTile(
                              value: isManager,
                              title: const Text('Yonetici Giriş'),
                              onChanged: (value) {
                                setState(() {
                                  isManager = value!;
                                });
                              })
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
