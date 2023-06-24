import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  Place(
      {required this.title,
      required this.picturePath,
      required this.lat,
      required this.lng})
      : id = uuid.v4();

  final String id;
  final String title;
  final String picturePath;
  final double lat;
  final double lng;
}
