import 'package:flutter/material.dart';
import 'package:kivi_app/screens/welcome.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Group.png'),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'KiviApp',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
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
