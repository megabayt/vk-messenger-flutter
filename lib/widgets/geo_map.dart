import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vk_messenger_flutter/blocs/attachments/attachments_bloc.dart';
import 'package:vk_messenger_flutter/screens/app_router.dart';

// TODO: Add floating action button blinking when searching location

class GeoMap extends StatefulWidget {
  static final CameraPosition initialCamera = CameraPosition(
    target: LatLng(55.7558, 37.6173),
    zoom: 10,
  );

  @override
  _GeoMapState createState() => _GeoMapState();
}

class _GeoMapState extends State<GeoMap> {
  Completer<GoogleMapController> _controller = Completer();

  LatLng gpsLocation;
  bool searchingCurrentLocation = false;

  LatLng customLocation;

  get markers {
    if (customLocation != null) {
      return Set<Marker>()
        ..add(Marker(
          markerId: MarkerId('my location'),
          position: customLocation,
        ));
    }
    if (gpsLocation != null) {
      return Set<Marker>()
        ..add(Marker(
          markerId: MarkerId('my location'),
          position: gpsLocation,
        ));
    }

    return Set<Marker>()
      ..add(Marker(
        markerId: MarkerId('my location'),
        position: LatLng(0, 0),
      ));
  }

  void _findMyLocation(BuildContext context) async {
    if (searchingCurrentLocation) {
      return;
    }
    searchingCurrentLocation = true;
    setState(() {
      customLocation = null;
    });
    try {
      LocationPermission checkPermission = await Geolocator.checkPermission();

      if (checkPermission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }

      checkPermission = await Geolocator.checkPermission();

      if (checkPermission == LocationPermission.denied) {
        final snackBar = SnackBar(
          content: Text('Нет доступа к местоположению'),
          action: SnackBarAction(
            label: 'Повторить',
            onPressed: () => _findMyLocation(context),
          ),
        );

        Scaffold.of(context).showSnackBar(snackBar);

        throw Exception('no permission');
      }

      if (checkPermission == LocationPermission.deniedForever) {
        final snackBar = SnackBar(
          content: Text('Нет доступа к местоположению'),
        );

        Scaffold.of(context).showSnackBar(snackBar);

        throw Exception('no permission');
      }

      Position location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        gpsLocation = LatLng(location.latitude, location.longitude);
      });

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: gpsLocation, zoom: 15),
        ),
      );
    } catch (_) {}
    searchingCurrentLocation = false;
  }

  void _handleMapTap(LatLng location) {
    setState(() {
      customLocation = location;
    });
  }

  void _handleConfirm(BuildContext context) {
    BlocProvider.of<AttachmentsBloc>(context)
        .add(AttachmentsAttachLocation(customLocation ?? gpsLocation));
    AppRouter.sailor.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: GoogleMap(
              initialCameraPosition: GeoMap.initialCamera,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _findMyLocation(context);
                _controller.complete(controller);
              },
              onTap: _handleMapTap,
              markers: markers,
            ),
          ),
          if (customLocation != null || gpsLocation != null)
            SizedBox(
              width: double.infinity,
              // TODO: разобраться, как убрать лишний отступ
              child: RaisedButton(
                onPressed: () => _handleConfirm(context),
                child: Text('Подтвердить'),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _findMyLocation(context),
        child: Icon(Icons.my_location),
      ),
    );
  }
}
