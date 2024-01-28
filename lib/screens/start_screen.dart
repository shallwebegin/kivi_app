import 'package:flutter/material.dart';
import 'package:kivi_app/screens/information.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Group.png'),
            const SizedBox(
              height: 20,
            ),
            Text(
              'KiviApp',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const InformationScreen(),
                ));
              },
              label: const Text('Get Start'),
              icon: const Icon(Icons.login),
            ),
          ],
        ),
      ),
    );
  }
}
