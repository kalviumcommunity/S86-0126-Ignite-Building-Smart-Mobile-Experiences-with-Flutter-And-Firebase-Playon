import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

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

  final Set<Marker> _markers = {};

  StreamSubscription<Position>? _positionStreamSub;

  Marker? _userMarker;

  Future<void> _ensurePermissions() async {
    LocationPermission permission;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }
  }

  Future<void> _initLocation() async {
    try {
      await _ensurePermissions();

      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      final userLatLng = LatLng(pos.latitude, pos.longitude);

      _userMarker = Marker(
        markerId: const MarkerId('currentLocation'),
        position: userLatLng,
        infoWindow: const InfoWindow(title: 'You are here'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );

      setState(() {
        _markers.addAll({_userMarker!});
      });

      final controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: userLatLng, zoom: 15)));

      _positionStreamSub = Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 5)).listen((Position p) async {
        final updated = LatLng(p.latitude, p.longitude);
        _userMarker = Marker(
          markerId: const MarkerId('currentLocation'),
          position: updated,
          infoWindow: const InfoWindow(title: 'You are here'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        );
        setState(() {
          _markers.removeWhere((m) => m.markerId == const MarkerId('currentLocation'));
          _markers.add(_userMarker!);
        });
        final ctl = await _controller.future;
        ctl.animateCamera(CameraUpdate.newLatLng(updated));
      });
    } catch (e) {
      // ignore errors for permission issues
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map')),
      body: GoogleMap(
        initialCameraPosition: _initialCamera,
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) _controller.complete(controller);
        },
        zoomControlsEnabled: true,
        mapType: MapType.normal,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Delay initialization slightly to ensure map controller can be completed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initLocation();
    });
  }

  @override
  void dispose() {
    _positionStreamSub?.cancel();
    super.dispose();
  }
}
