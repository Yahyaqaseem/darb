import 'package:latlong2/latlong.dart';

class PlaceResult {
  final String id;
  final String name;
  final LatLng location;
  final String type;

  PlaceResult({
    required this.id,
    required this.name,
    required this.location,
    required this.type,
  });
}

abstract class IGeocodingProvider {
  Future<List<PlaceResult>> search(String query);
  Future<PlaceResult?> reverseGeocode(LatLng location);
}
