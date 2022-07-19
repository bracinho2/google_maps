import 'dart:async';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends NotifierStore<Exception, GoogleMap> {
  MapController()
      : super(GoogleMap(
            initialCameraPosition: CameraPosition(
          target: LatLng(
            -25.70638,
            -52.72884,
          ),
          zoom: 15,
        )));

  LocationData? currentLocation;
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _sulina = const CameraPosition(
      bearing: 0,
      target: LatLng(
        -25.69898,
        -52.72497,
      ),
      tilt: 59.440717697143555,
      zoom: 15);

  getInitialMap() {
    setLoading(true);
    print('aqui');

    final map = GoogleMap(initialCameraPosition: _sulina);

    //update(map, force: true);
    setLoading(false);
  }

  void getCurrentLocation() async {
    setLoading(true);
    Location location = Location();
    location.getLocation().then((location) => currentLocation = location);

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen(
      (newLocation) {
        currentLocation = newLocation;

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                newLocation.latitude!,
                newLocation.longitude!,
              ),
              zoom: 15,
            ),
          ),
        );
        setLoading(false);
      },
    );
  }
}
