import 'package:flutter/material.dart';

import 'package:favorite_places/widgets/places_list.dart';
import 'package:favorite_places/screens/add_place.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  void _pushPlacesScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddPlaceScreen(),
      ),
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _pushPlacesScreen(context);
            },
          ),
        ],
      ),
      body: const PlacesList(places: []),
    );
  }
}
