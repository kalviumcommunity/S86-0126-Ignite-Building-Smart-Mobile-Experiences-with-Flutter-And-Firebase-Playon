import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(28.6139, 77.2090), // New Delhi as example
    zoom: 12,
  );

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('delhi'),
      position: LatLng(28.6139, 77.2090),
      infoWindow: InfoWindow(title: 'Marker in New Delhi'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map')),
      body: GoogleMap(
        initialCameraPosition: _initialCamera,
        markers: _markers,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) _controller.complete(controller);
        },
        zoomControlsEnabled: true,
        mapType: MapType.normal,
      ),
    );
  }
}
