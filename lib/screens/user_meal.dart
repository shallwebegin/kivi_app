import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kivi_app/providers/user_provider.dart';
import 'package:kivi_app/screens/add_meal.dart';
import 'package:kivi_app/widgets/user_list.dart';

class UserMealScreen extends ConsumerWidget {
  const UserMealScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eklenenYemek = ref.watch(userMealProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Yemekleriniz'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddMealScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: UserList(users: eklenenYemek),
      ),
    );
  }
}
