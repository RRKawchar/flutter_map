import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({Key? key}) : super(key: key);

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation =
  LatLng(23.862722386195372, 90.38553231014907);
  static const LatLng destination =
  LatLng(23.867675452935778, 90.40623694971248);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      sourceLocation.latitude,
      sourceLocation.longitude,
    ),
    zoom: 13.5,
  );

  final List<Marker> _marker = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(23.862722386195372, 90.38553231014907),
        infoWindow: InfoWindow(title: "destination")),
  ];

  loadCurrentLocation(){
    getUserCurrentLocation().then((value) async{
      _marker.add(Marker(
          markerId: const MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: "My Current Location")));

      CameraPosition cameraPosition = CameraPosition(
        zoom: 14.0,
        target: LatLng(value.latitude, value.longitude),
      );

      final GoogleMapController controller= await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {

      });
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("Error : $error");
    });

    return await Geolocator.getCurrentPosition();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(_marker)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then((value) async{
            print("My Current Location");
            print("${value.latitude}, ${value.longitude}");

            _marker.add(Marker(
                markerId: const MarkerId('2'),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: const InfoWindow(title: "My Current Location")));

            CameraPosition cameraPosition = CameraPosition(
              zoom: 14.0,
              target: LatLng(value.latitude, value.longitude),
            );

            final GoogleMapController controller= await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

            setState(() {

            });
          });


        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}