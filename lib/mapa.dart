import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps/platform_info.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key? key}) : super(key: key);

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  @override
  Widget build(BuildContext context) {
    return const MapSample();
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _sulina = const CameraPosition(
    target: LatLng(
      -25.70638,
      -52.72884,
    ),
    zoom: 15,
  );

  final CameraPosition _linhaCanarinho = const CameraPosition(
      bearing: 0,
      target: LatLng(
        -25.69898,
        -52.72497,
      ),
      tilt: 59.440717697143555,
      zoom: 15);

  final LatLng _origem = const LatLng(
    -25.70638,
    -52.72884,
  );

  final LatLng _destino = const LatLng(
    -25.69898,
    -52.72497,
  );

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyAfuRvaWjpfexdWfHYnlQ2tE-NZLKiktzs', // Your Google Map Key
      PointLatLng(_origem.latitude, _origem.longitude),
      PointLatLng(_destino.latitude, _destino.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  LocationData? currentLocation;

  void getCurrentLocation() async {
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
        setState(() {});
      },
    );
  }

  BitmapDescriptor custoIcom = BitmapDescriptor.defaultMarker;

  void setCustomMarker() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 1.0),
            'assets/images/avatar.jpeg')
        .then((icon) => custoIcom = icon);
  }

  @override
  void initState() {
    getPolyPoints();
    getCurrentLocation();
    setCustomMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefinePlatform(
        widget: Scaffold(
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  currentLocation!.latitude!,
                  currentLocation!.longitude!,
                ),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                Marker(
                  markerId: const MarkerId('origem'),
                  position: _origem,
                ),
                Marker(
                  markerId: const MarkerId('destino'),
                  position: _destino,
                ),
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId('rota'),
                  points: polylineCoordinates,
                  color: Colors.blue,
                  width: 6,
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToTheLake,
        child: const Icon(Icons.arrow_forward),
      ),
    ));
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_linhaCanarinho));
  }
}
