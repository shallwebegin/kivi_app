import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kivi_app/models/users.dart';
import 'package:kivi_app/providers/user_provider.dart';
import 'package:kivi_app/widgets/image_input.dart';
import 'package:kivi_app/widgets/location_input.dart';

class AddMealScreen extends ConsumerStatefulWidget {
  const AddMealScreen({super.key});

  @override
  ConsumerState<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends ConsumerState<AddMealScreen> {
  final _titleController = TextEditingController();
  File? cekilmisFotograf;
  PlaceLocation? secilmisLocation;
  void yemekEkle() {
    final yemekAdi = _titleController.text;
    if (yemekAdi.isEmpty ||
        cekilmisFotograf == null ||
        secilmisLocation == null) {
      return;
    }
    ref
        .read(userMealProvider.notifier)
        .yemekEkle(yemekAdi, cekilmisFotograf!, secilmisLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yemek Tarifini Ekle'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Yemeğiniz '),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 50,
            ),
            ImageInput(
              fotografiKaydet: (image) {
                cekilmisFotograf = image;
              },
            ),
            const SizedBox(
              height: 50,
            ),
            LocationInput(
              onPickLocation: (location) {
                secilmisLocation = location;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: yemekEkle,
              icon: const Icon(Icons.save),
              label: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
