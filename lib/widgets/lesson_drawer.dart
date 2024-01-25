import 'package:flutter/material.dart';
import 'package:kivi_app/screens/homepage.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});
  final void Function(String identifier) onSelectScreen;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary.withOpacity(0.8)
            ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Group.png',
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              'Dersler',
              style: TextStyle(fontSize: 24),
            ),
            leading: const Icon(Icons.change_history),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AnaSayfaScreen(availableMeals: []),
              ));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            title: const Text(
              'Filtreler',
              style: TextStyle(fontSize: 24),
            ),
            leading: const Icon(Icons.settings),
            onTap: () {
              onSelectScreen('Filtreler');
            },
          ),
        ],
      ),
    );
  }
}
