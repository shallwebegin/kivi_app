import 'package:flutter/material.dart';
import 'package:kivi_app/screens/credential.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Image.asset(
              'assets/images/kivi.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
            ),
          ),
          Positioned(
            bottom: 400,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 80,
                    child: Image.asset('assets/images/Group.png'),
                  ),
                ),
                Text(
                  'Welcome to Kivi App',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                Text(
                  'Welcome to Kivi App',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
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
                    fixedSize: const Size(220, 4),
                  ),
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
