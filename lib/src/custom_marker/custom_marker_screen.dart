import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({Key? key}) : super(key: key);

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  Uint8List? markerImage;
  List<String> images = [
    "assets/images/car.png",
    "assets/images/bus.png",
    "assets/images/motorcycle.png",
    "assets/images/marker.png",
    "assets/images/marker2.png",
    "assets/images/marker3.png",
  ];

  final List<Marker> _marker = <Marker>[];
  final List<LatLng> _latLng = <LatLng>[
    const LatLng(23.86838811968793, 90.38599420598435),
    const LatLng(23.865167872845046, 90.396630454088),
    const LatLng(23.872196190745168, 90.38308383314877),
    const LatLng(23.87081280684265, 90.38740754352915),
    const LatLng(23.889526124621188, 90.40050655594375),
    const LatLng(23.86178120462871, 90.35333805892607),
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(23.87131478685995, 90.39665695527056), zoom: 14.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < _latLng.length; i++) {
      final Uint8List markerIcon = await getByteFromAssets(images[i], 100);
      _marker.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latLng[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: "Marker $i"
          )
        ),
      );
      setState(() {

      });
    }
  }

  Future<Uint8List> getByteFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();

    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_marker),
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
