import 'package:flutter/material.dart';
import 'package:kivi_app/screens/credential.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset('assets/images/Group.png'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Welcome to KiviApp',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Lets Begin',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CredentialScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(150, 22),
              ),
              child: const Text('Start'),
            )
          ],
        ),
      ),
    );
  }
}
