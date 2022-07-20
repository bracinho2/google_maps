import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsTest extends StatefulWidget {
  const GoogleMapsTest({Key? key}) : super(key: key);

  @override
  State<GoogleMapsTest> createState() => _GoogleMapsTestState();
}

class _GoogleMapsTestState extends State<GoogleMapsTest> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = LatLng(
    -25.70116,
    -52.72136,
  );

  static const LatLng _casa = LatLng(
    -25.70663,
    -52.72877,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Google Maps',
        ),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: _center,
          zoom: 20,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.map),
          onPressed: () async {
            GoogleMapController googleMapController = await _controller.future;
            setState(
              () {
                googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(const CameraPosition(
                  target: _casa,
                  zoom: 15,
                )));
              },
            );
          }),
    );
  }
}
