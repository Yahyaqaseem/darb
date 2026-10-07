import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/repositories/i_routing_provider.dart';

class OsrmRoutingProvider implements IRoutingProvider {
  final Dio _dio;
  
  // Using public OSRM for dev, should be replaced with DARB's own OSRM instance
  final String _baseUrl = 'http://router.project-osrm.org/route/v1/driving';

  OsrmRoutingProvider(this._dio);

  @override
  Future<RouteResult> getRoute(LatLng origin, LatLng destination) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}',
        queryParameters: {
          'overview': 'full',
          'geometries': 'geojson',
          'steps': 'true',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          
          final List<dynamic> coordinatesData = route['geometry']['coordinates'];
          final List<LatLng> coordinates = coordinatesData
              .map((coord) => LatLng(coord[1], coord[0]))
              .toList();

          return RouteResult(
            coordinates: coordinates,
            distance: route['distance'].toDouble(),
            duration: route['duration'].toDouble(),
            polyline: '', // Can be filled if polyline5 is used
          );
        }
      }
      throw Exception('Failed to calculate route');
    } catch (e) {
      throw Exception('Routing Provider Error: $e');
    }
  }

  @override
  Future<List<RouteResult>> getAlternativeRoutes(LatLng origin, LatLng destination) async {
    // Basic implementation for alternative routes
    final mainRoute = await getRoute(origin, destination);
    return [mainRoute];
  }
}
