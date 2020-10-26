import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vk_messenger_flutter/models/geo.dart';

class ShowGeoScreen extends StatelessWidget {
  static const routeUrl = '/show_geo';

  final Geo geo;

  CameraPosition get initialCamera {
    return CameraPosition(
      target: LatLng(geo.coordinates.latitude, geo.coordinates.longitude),
      zoom: 10,
    );
  }

  Set<Marker> get markers {
    return Set<Marker>()
      ..add(Marker(
        markerId: MarkerId('my location'),
        position: LatLng(geo.coordinates.latitude, geo.coordinates.longitude),
      ));
  }

  ShowGeoScreen(this.geo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(geo?.place?.title ?? 'Местоположение'),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCamera,
        zoomControlsEnabled: true,
        markers: markers,
      ),
    );
  }
}
