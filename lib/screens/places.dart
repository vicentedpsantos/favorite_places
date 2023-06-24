import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/widgets/places_list.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/models/place.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  void _pushPlacesScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddPlaceScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Place> places = ref.watch(userPlacesProvider);

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
      body: PlacesList(places: places),
    );
  }
}
