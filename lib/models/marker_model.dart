import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerModel {
  const MarkerModel({
    required this.id,
    required this.title,
    required this.position,
    required this.price,
    required,
  });
  final String id;
  final String title;
  final String price;
  final LatLng position;
}
