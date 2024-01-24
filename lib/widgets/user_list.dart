import 'package:flutter/material.dart';
import 'package:kivi_app/models/users.dart';
import 'package:kivi_app/screens/meal_detail.dart';

class UserList extends StatelessWidget {
  const UserList({super.key, required this.users});
  final List<Users> users;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MealDetailScreen(usersmeal: users[index]),
            ),
          );
        },
        child: ListTile(
          title: Text(users[index].title),
          leading: CircleAvatar(
            backgroundImage: FileImage(users[index].image),
          ),
          subtitle: Text(users[index].location.address),
        ),
      ),
    );
  }
}
