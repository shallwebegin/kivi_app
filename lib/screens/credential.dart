import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kivi_app/screens/ogrenci.dart';
import 'package:kivi_app/screens/yonetici.dart';

class CredentialScreen extends StatefulWidget {
  const CredentialScreen({super.key});

  @override
  State<CredentialScreen> createState() => _CredentialScreenState();
}

class _CredentialScreenState extends State<CredentialScreen> {
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  final _form = GlobalKey<FormState>();
  var isLogin = true;
  var isManager = false;
  var isAuthentication = false;
  void kullaniciIslemleri() async {
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
          return showAlertDialog(
              context, 'Hata', 'Yonetici Yetkisin Sahip Degilsiniz');
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                isManager ? YoneticiScreen() : OgrenciScreen(),
          ));
        }
      } else {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _enteredEmail, password: _enteredPassword);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use' ||
          error.code == 'invalid-email' ||
          error.code == 'user-not-found' ||
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
    return user.email != null && user.email!.contains('@yonetici.com');
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
              Hero(
                tag: 'logo',
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.only(
                      top: 30, left: 20, right: 20, bottom: 20),
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
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Email Address'),
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Lütfen Geçerli bir Email Adresi Giriniz';
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
                            autocorrect: false,
                            validator: (value) {
                              if (value == null || value.trim().length < 4) {
                                return 'Lütfen Geçerli bir Username  Giriniz';
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
                              return 'Lütfen Geçerli bir şifre Giriniz';
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
                              ? 'Create an Account'
                              : 'I already have account'),
                        ),
                        CheckboxListTile(
                            title: const Text('Yönetici Girşi'),
                            value: isManager,
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
