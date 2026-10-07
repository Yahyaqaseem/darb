import 'package:latlong2/latlong.dart';

class RouteResult {
  final List<LatLng> coordinates;
  final double distance; // In meters
  final double duration; // In seconds
  final String polyline;

  RouteResult({
    required this.coordinates,
    required this.distance,
    required this.duration,
    required this.polyline,
  });
}

abstract class IRoutingProvider {
  Future<RouteResult> getRoute(LatLng origin, LatLng destination);
  Future<List<RouteResult>> getAlternativeRoutes(LatLng origin, LatLng destination);
}
