import 'package:flutter/material.dart';
import 'package:kivi_app/models/users.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key, required this.usersmeal});
  final Users usersmeal;
  String get konumFotografi {
    final lat = usersmeal.location.latitude;
    final lng = usersmeal.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$lng&key=AIzaSyAsyPGXLY44JCgTUM8ihUVip2big8VwM9E';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(usersmeal.title),
      ),
      body: Stack(
        children: [
          Image.file(
            usersmeal.image,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(konumFotografi),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    usersmeal.location.address,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
