import 'package:flutter/material.dart';
import 'package:kivi_app/screens/credential.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/kivilerce.jpg',
              height: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'KiviApp',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CredentialScreen(),
                  ),
                );
              },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
