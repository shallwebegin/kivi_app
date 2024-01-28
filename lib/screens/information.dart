import 'package:flutter/material.dart';
import 'package:kivi_app/screens/credential.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/kivi.jpg',
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 400,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Group.png',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Welcome to Kivi App',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  Text(
                    'Have fun and improve yourself by solving questions',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  const SizedBox(
                    height: 5,
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
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer),
                    child: const Text('Lets Begin'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
