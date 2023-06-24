import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({required this.onGetLocationData, super.key});

  final void Function(double lat, double lng) onGetLocationData;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData? _locationData;
  var _isGettingLocation = false;

  void _getCurrentLocation() async {
    setState(() {
      _isGettingLocation = true;
    });

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    setState(() {
      _locationData = locationData;
    });

    widget.onGetLocationData(
      locationData.latitude!,
      locationData.longitude!,
    );

    

    setState(() {
      _isGettingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String locationContent = 'No location chosen';

    if (_locationData != null) {
      locationContent =
          'Lat ${_locationData!.latitude} Lng ${_locationData!.longitude}';
    }

    Widget content = Text(
      locationContent,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_isGettingLocation) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: content,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get current location'),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
