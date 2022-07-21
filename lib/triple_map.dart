import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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
  StreamSubscription<LocationData>? locationSubscription;
  Location location = Location();

  @override
  void initState() {
    print('Inicia o Mapa!');
    setCustomMarker();
    getCurrentLocation();
    super.initState();
  }

  static const LatLng _center = LatLng(
    -25.69961,
    -52.72605,
  );

  static const LatLng _casa = LatLng(
    -25.70663,
    -52.72877,
  );

  void _onMapCreated(GoogleMapController controller) {
    _googleMapsController.complete(controller);
  }

  void getCurrentLocation() async {
    location.getLocation().then((newLocation) {
      currentLocation = newLocation;
      setState(() {});
    });

    GoogleMapController googleMapController =
        await _googleMapsController.future;

    // locationSubscription = location.onLocationChanged.listen(
    //   (newLocation) {
    //     currentLocation = newLocation;

    //     googleMapController.animateCamera(
    //       CameraUpdate.newCameraPosition(
    //         CameraPosition(
    //           target: LatLng(newLocation.latitude!, newLocation.longitude!),
    //           zoom: 17,
    //         ),
    //       ),
    //     );

    //     setState(
    //       () {},
    //     );
    //   },
    // );
  }

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyAfuRvaWjpfexdWfHYnlQ2tE-NZLKiktzs', // Your Google Map Key
      PointLatLng(_center.latitude, _center.longitude),
      PointLatLng(_casa.latitude, _casa.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );

      print(polylineCoordinates);
      setState(() {});
    }
  }

  BitmapDescriptor custoIcom = BitmapDescriptor.defaultMarker;

  void setCustomMarker() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), 'assets/images/truck128.png')
        .then((icon) => custoIcom = icon);
  }

  @override
  void dispose() {
    print('Encerra o Mapa!');
    //locationSubscription!.cancel();
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
              mapToolbarEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  currentLocation!.latitude!,
                  currentLocation!.longitude!,
                ),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  icon: custoIcom,
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                Marker(
                  markerId: const MarkerId("centro"),
                  icon: custoIcom,
                  position: LatLng(
                    _center.latitude,
                    _center.longitude,
                  ),
                ),
                Marker(
                  markerId: const MarkerId("casa"),
                  icon: custoIcom,
                  position: LatLng(
                    _casa.latitude,
                    _casa.longitude,
                  ),
                ),
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: polylineCoordinates,
                  color: const Color(0xFF7B61FF),
                  width: 6,
                ),
              },
              zoomControlsEnabled: false,
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[700],
          child: const Icon(Icons.map),
          onPressed: () {
            getCurrentLocation();
          }),
    );
  }
}
