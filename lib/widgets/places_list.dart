import 'dart:io';
import 'package:flutter/material.dart';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_details.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  void _viewDetailsOf(BuildContext context, Place place) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PlaceDetailsScreen(
          place: place,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => Container(
        padding: const EdgeInsets.only(top: 12),
        child: ListTile(
          leading: Hero(
            tag: places[index].id,
            child: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(
                File(places[index].picturePath),
              ),
            ),
          ),
          onTap: () {
            _viewDetailsOf(context, places[index]);
          },
          title: Text(
            places[index].title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ),
    );
  }
}
