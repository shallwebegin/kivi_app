import 'package:flutter/material.dart';
import 'package:kivi_app/credential.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Image.asset('assets/images/welcome.png'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset('assets/images/Group.png'),
              ),
              Text(
                'Welcome to our Store',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Theme.of(context).colorScheme.background),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Ger your groceries in as fast as one hour',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.background),
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
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer),
                child: const Text('Get Started'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
