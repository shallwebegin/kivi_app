import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.fotografiKaydet});
  final void Function(File image) fotografiKaydet;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? cekilmisFotograf;
  void loadPicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      cekilmisFotograf = File(pickedImage.path);
    });
    widget.fotografiKaydet(cekilmisFotograf!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: loadPicture,
      icon: const Icon(Icons.camera),
      label: const Text('Fotografini cek'),
    );
    if (cekilmisFotograf != null) {
      content = Image.file(
        cekilmisFotograf!,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
            ),
          ),
          height: 250,
          width: double.infinity,
          child: content,
        ),
      ],
    );
  }
}
