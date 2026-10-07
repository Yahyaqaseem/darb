import 'package:latlong2/latlong.dart';

abstract class IMapProvider {
  void initialize();
  void setStyle(String styleUrl);
  void moveCamera(LatLng center, double zoom);
  void addMarker(String id, LatLng position, String icon);
  void removeMarker(String id);
  void clearRoute();
  void drawRoute(List<LatLng> coordinates);
}
