import 'package:flutter/material.dart';
import 'package:kivi_app/credential.dart';

class YoneticiSayfasi extends StatelessWidget {
  const YoneticiSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KiviApp'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CredentialScreen(),
                ));
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(child: Text('Yonetici')),
    );
  }
}
