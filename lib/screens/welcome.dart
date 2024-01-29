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
              height: double.infinity,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 330,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 60,
                    child: Image.asset('assets/images/Group.png'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome to KiviApp',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Lets Begin',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
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
