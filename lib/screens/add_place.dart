import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  String? filePath;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _addPlace() {
    if (filePath == null) return;
    if (_titleController.text.isEmpty) return;

    final newPlace =
        Place(title: _titleController.text, picturePath: filePath!);
    ref.read(userPlacesProvider.notifier).addPlace(newPlace);

    Navigator.of(context).pop();
  }

  void _onSetPicture(String pictureTakenPath) {
    filePath = pictureTakenPath;
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            // Image input
            const SizedBox(height: 12),
            ImageInput(onSetPicture: _onSetPicture),
            const SizedBox(height: 12),
            LocationInput(),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _addPlace,
              icon: const Icon(Icons.add),
              label: const Text('Add place'),
            )
          ],
        ),
      ),
    );
  }
}
