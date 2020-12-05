import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowGeoScreen extends StatelessWidget {
  static const routeUrl = '/show_geo';

  ShowGeoScreen(
    this.longitude,
    this.latitude,
    this.place,
  );

  final double longitude;
  final double latitude;
  final String place;

  CameraPosition get initialCamera {
    return CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 10,
    );
  }

  Set<Marker> get markers {
    return Set<Marker>()
      ..add(Marker(
        markerId: MarkerId('my location'),
        position: LatLng(latitude, longitude),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place ?? 'Местоположение'),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCamera,
        zoomControlsEnabled: true,
        markers: markers,
      ),
    );
  }
}
