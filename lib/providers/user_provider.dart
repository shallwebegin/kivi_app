import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kivi_app/models/users.dart';

class UserMealNotifier extends StateNotifier<List<Users>> {
  UserMealNotifier() : super(const []);
  void yemekEkle(String title, File image, PlaceLocation location) {
    final yemekEkle = Users(title: title, image: image, location: location);
    state = [yemekEkle, ...state];
  }
}

final userMealProvider = StateNotifierProvider<UserMealNotifier, List<Users>>(
    (ref) => UserMealNotifier());
