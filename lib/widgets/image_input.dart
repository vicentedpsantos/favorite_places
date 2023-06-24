import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker picker = ImagePicker();

class ImageInput extends StatefulWidget {
  const ImageInput({required this.onSetPicture, super.key});

  final void Function(String filePath) onSetPicture;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedPicture;

  void _takePicture() async {
    final XFile? picture =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (picture == null) return;

    widget.onSetPicture(picture.path);
    setState(() {
      _selectedPicture = File(picture.path);
    });
  }

  @override
  Widget build(context) {
    Widget content = TextButton.icon(
        icon: const Icon(Icons.camera),
        label: const Text('Take picture'),
        onPressed: _takePicture);

    if (_selectedPicture != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(_selectedPicture!, fit: BoxFit.cover),
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
