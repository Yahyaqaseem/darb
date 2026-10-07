import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../emergency/presentation/sos_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  final LatLng _initialCenter = const LatLng(36.1901, 44.0090); // Erbil

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // The Map Layer
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _initialCenter,
              initialZoom: 15.0,
              maxZoom: 18.0,
              minZoom: 5.0,
              cameraConstraint: CameraConstraint.unconstrained(),
            ),
            children: [
              TileLayer(
                // In production, use vector tiles with custom DARB style (Dark Navy/Gold)
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.darb.mobile',
              ),
              // Premium GPS Puck Marker
              MarkerLayer(
                markers: [
                  Marker(
                    point: _initialCenter,
                    width: 60,
                    height: 60,
                    child: _buildNavigationPuck(),
                  )
                ],
              )
            ],
          ),

          // Top Search Bar Overlays
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 20,
            right: 20,
            child: _buildGlassSearchBar(),
          ),

          // Map Controls Overlays
          Positioned(
            bottom: 120, // Above bottom nav
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildGlassMapButton(
                  icon: Icons.layers_rounded,
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _buildGlassMapButton(
                  icon: Icons.my_location_rounded,
                  onTap: () {
                    _animatedMapMove(_initialCenter, 15.0);
                  },
                ),
              ],
            ).animate().slideX(begin: 1, end: 0, duration: 600.ms, curve: Curves.easeOutBack),
          ),
          
          // SOS Button Overlay
          Positioned(
            bottom: 120,
            left: 20,
            child: _buildSosButton(context)
                .animate()
                .slideX(begin: -1, end: 0, duration: 600.ms, curve: Curves.easeOutBack),
          ),
        ],
      ),
    );
  }

  Widget _buildSosButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Will be wired to the SOS sheet import properly at the top of file
        showSosSheet(context);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF991B1B), // SOS Red
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF991B1B).withOpacity(0.4),
              blurRadius: 15,
              spreadRadius: 2,
            )
          ],
        ),
        child: const Icon(Icons.sos_rounded, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildGlassSearchBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search_rounded, color: Color(0xFFEAB308), size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'إلى أين تريد الذهاب؟', // Where to?
                    hintStyle: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F2F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.mic_rounded, color: Color(0xFF0F172A)),
              ),
            ],
          ),
        ),
      ),
    ).animate().slideY(begin: -1, end: 0, duration: 600.ms, curve: Curves.easeOutBack);
  }

  Widget _buildGlassMapButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Icon(icon, color: const Color(0xFF0F172A), size: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationPuck() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulsing Accuracy Ring
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFEAB308).withOpacity(0.2),
          ),
        ).animate(onPlay: (controller) => controller.repeat())
         .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.5, 1.5), duration: 2.seconds)
         .fadeOut(duration: 2.seconds),
        
        // Core Puck
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFEAB308),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 2,
              )
            ],
          ),
        ),
      ],
    );
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Custom camera animation logic (simplified for the scope of this file)
    final latTween = Tween<double>(begin: _mapController.camera.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(begin: _mapController.camera.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: _mapController.camera.zoom, end: destZoom);

    final animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    final Animation<double> animation = CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

    animationController.addListener(() {
      _mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        animationController.dispose();
      }
    });

    animationController.forward();
  }
}
