import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker picker = ImagePicker();

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final XFile? photo =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (photo == null) return;

    setState(() {
      _selectedImage = File(photo.path);
    });
  }

  @override
  Widget build(context) {
    Widget content = TextButton.icon(
        icon: const Icon(Icons.camera),
        label: const Text('Take picture'),
        onPressed: _takePicture);

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(_selectedImage!, fit: BoxFit.cover),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}