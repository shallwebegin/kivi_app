import 'package:flutter/material.dart';

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
            child: Row(
              children: [
                Icon(
                  Icons.book,
                  size: 40,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Start Tests!',
                  style: Theme.of(context).textTheme.titleLarge,
                  softWrap: true,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: Text(
              'Favorites',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            onTap: () {
              onSelectScreen('Favorites');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            onTap: () {
              onSelectScreen('Filters');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
