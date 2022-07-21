import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapsTest extends StatefulWidget {
  const GoogleMapsTest({Key? key}) : super(key: key);

  @override
  State<GoogleMapsTest> createState() => _GoogleMapsTestState();
}

class _GoogleMapsTestState extends State<GoogleMapsTest> {
  final Completer<GoogleMapController> _googleMapsController = Completer();
  LocationData? currentLocation;

  @override
  void initState() {
    print('Inicia o Mapa!');
    getCurrentLocation();
    super.initState();
  }

  static const LatLng _center = LatLng(
    -25.70116,
    -52.72136,
  );

  static const LatLng _casa = LatLng(
    -25.70663,
    -52.72877,
  );

  void _onMapCreated(GoogleMapController controller) {
    _googleMapsController.complete(controller);
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((newLocation) {
      currentLocation = newLocation;
      setState(() {});
    });

    GoogleMapController googleMapController =
        await _googleMapsController.future;

    location.onLocationChanged.listen(
      (newLocation) {
        currentLocation = newLocation;

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(newLocation.latitude!, newLocation.longitude!),
              zoom: 15,
            ),
          ),
        );

        setState(
          () {
            print('Mapa carregado!');
          },
        );
      },
    );
  }

  @override
  void dispose() {
    print('Encerra o Mapa!');
    super.dispose();
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
      body: currentLocation == null
          ? const Center(child: LinearProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  currentLocation!.latitude!,
                  currentLocation!.longitude!,
                ),
                zoom: 20,
              ),
            ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.map),
          onPressed: () async {
            GoogleMapController googleMapController =
                await _googleMapsController.future;
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
