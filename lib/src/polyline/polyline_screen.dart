import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineScreen extends StatefulWidget {
  const PolyLineScreen({Key? key}) : super(key: key);

  @override
  State<PolyLineScreen> createState() => _PolyLineScreenState();
}

class _PolyLineScreenState extends State<PolyLineScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(23.872881, 90.380866),
    zoom: 14.0,
  );

  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline = {};

  final List<LatLng> _latLng = [
    const LatLng(23.872881, 90.380866),
    const LatLng(23.876904765072762, 90.36760201451858),
    const LatLng(23.87185280568283, 90.38283706992686),
    const LatLng(23.870314517979853, 90.39777242046861),
    const LatLng(23.86503051147386, 90.39653389456639),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < _latLng.length; i++) {
      _marker.add(
        Marker(
            markerId: MarkerId(i.toString()),
            infoWindow: const InfoWindow(
                title: "Beautiful Place", snippet: "5 star rating"),
            position: _latLng[i],
            icon: BitmapDescriptor.defaultMarker),
      );
      setState(() {});
    }

    _polyline.add(
      Polyline(
        polylineId: const PolylineId('1'),
        points: _latLng,
        color: Colors.deepOrange
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polyline"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        markers: _marker,
        myLocationEnabled: true,
        mapType: MapType.normal,
        polylines: _polyline,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
