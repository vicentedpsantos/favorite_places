import 'dart:io';
import 'package:flutter/material.dart';

import 'package:favorite_places/models/place.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({required this.place, super.key});

  final Place place;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Hero(
            tag: place.id,
            child: Image.file(
              File(place.picturePath),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
