import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({Key? key}) : super(key: key);

  @override
  State<PolygoneScreen> createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(23.869200, 90.383949), zoom: 14.0);


  Set<Polygon> _polygon=HashSet<Polygon>();


  List<LatLng> points=[
    const LatLng(23.869200, 90.383949),
    const LatLng(23.873944, 90.378972),
    const LatLng(23.872119, 90.385087),
    const LatLng(23.862646, 90.369496),
    const LatLng(23.870479, 90.387429),
    const LatLng(23.869200, 90.383949),


  ];


  @override
  void initState() {
    super.initState();

    _polygon.add(Polygon(polygonId: const PolygonId('1'),points: points,
    fillColor: Colors.red,
      geodesic: true,
      strokeWidth: 4,
      strokeColor: Colors.redAccent

    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Polygone "),
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        polygons: _polygon,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
