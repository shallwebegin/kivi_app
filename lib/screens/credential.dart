import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:kivi_app/screens/homepage.dart';
import 'package:kivi_app/screens/ogrenci.dart';

import 'package:kivi_app/widgets/kullanici_image_picker.dart';
import 'package:kivi_app/screens/yonetici.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firebase = FirebaseAuth.instance;

class CredentialScreen extends StatefulWidget {
  const CredentialScreen({super.key});

  @override
  State<CredentialScreen> createState() => _CredentialScreenState();
}

class _CredentialScreenState extends State<CredentialScreen> {
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';
  var isLogin = true;
  var isManager = false;
  File? _secilmisFotograf;
  var isAuthenticating = false;
  var _enteredUsername = '';

  void uyeOl() async {
    final gecerliGiris = _form.currentState!.validate();
    if (!gecerliGiris || !isLogin && _secilmisFotograf == null) {
      return showAlertDialog(
        context,
        'Hata',
        'Profil Fotografi Secmediniz',
      );
    }

    _form.currentState!.save();
    try {
      setState(() {
        isAuthenticating = true;
      });
      if (isLogin) {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        // Giriş yaptıktan sonra kullanıcı türüne göre sayfaya yönlendirme
        if (isManager && !isUserManager(userCredentials.user!)) {
          showAlertDialog(
            context,
            'Hata',
            'Yönetici yetkisine sahip değilsiniz.',
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => isManager
                  ? YoneticiSayfasi()
                  : OgrenciSayfasi(), // Yönetici mi öğrenci mi olduğuna göre sayfa yönlendirme
            ),
          );
        }
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');
        await storageRef.putFile(
            _secilmisFotograf!, SettableMetadata(contentType: 'image/jpg'));
        final imageUrl = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
          'image_url': imageUrl,
        });
        // Yeni eklenen kullanıcı türüne göre sayfaya yönlendirme
        if (isManager && !isUserManager(userCredentials.user!)) {
          showAlertDialog(
            context,
            'Hata',
            'Yönetici yetkisine sahip değilsiniz.',
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => isManager
                  ? YoneticiSayfasi()
                  : OgrenciSayfasi(), // Yönetici mi öğrenci mi olduğuna göre sayfa yönlendirme
            ),
          );
        }
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found' || error.code == 'wrong-password') {
        // Kullanıcı adı veya şifre yanlış girildiğinde hata mesajı göster
        showAlertDialog(context, 'Hata', 'Kullanıcı adı veya şifre hatalı.');
      } else if (error.code == 'email-already-in-use') {
        // Başka bir kullanıcı tarafından kullanılan e-posta adresiyle kayıt olmaya çalıştığında hata mesajı göster
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication Failed'),
          ),
        );
        setState(() {
          isAuthenticating = false;
        });
      }
    }
  }

  // Kullanıcının yönetici olup olmadığını kontrol eden metod
  bool isUserManager(User user) {
    // Burada kullanıcının yönetici olup olmadığını kontrol etmek için bir koşul ekleyebilirsiniz.
    // Örneğin, kullanıcının e-posta adresine veya başka bir özelliğine bakarak kontrol edebilirsiniz.
    // Bu örnekte basit bir kontrol yapısı kullanılmıştır. Siz gerçek duruma uygun bir kontrol yapısı ekleyebilirsiniz.
    return user.email != null && user.email!.contains('@yonetici.com');
  }

  // Hata mesajı gösteren metod
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
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 100,
                margin: const EdgeInsets.only(
                    top: 30, left: 20, right: 20, bottom: 0),
                child: Image.asset(
                  'assets/images/Group.png',
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
                            onSelectedImage: (image) {
                              _secilmisFotograf = image;
                            },
                          ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Lütfen geçerli bir mail adresi giriniz';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredEmail = value!;
                          },
                        ),
                        if (!isLogin)
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Kullanici Adi'),
                            enableSuggestions: false,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length < 4) {
                                return 'Lütfen 4 karakterden fazla kullanici adi giriniz';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enteredUsername = value!;
                            },
                          ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Lütfen geçerli bir şifre giriniz';
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
                        if (isAuthenticating) const CircularProgressIndicator(),
                        if (!isAuthenticating)
                          ElevatedButton(
                            onPressed: uyeOl,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            child: Text(isLogin ? 'Giriş Yap' : 'Üye Ol'),
                          ),
                        if (!isAuthenticating)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(
                                isLogin ? 'Hesap Oluştur' : 'Bir hesabım var'),
                          ),
                        CheckboxListTile(
                          title: const Text('Yönetici Girişi'),
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
            ],
          ),
        ),
      ),
    );
  }
}
