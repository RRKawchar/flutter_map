import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageMarker extends StatefulWidget {
  const NetworkImageMarker({Key? key}) : super(key: key);

  @override
  State<NetworkImageMarker> createState() => _NetworkImageMarkerState();
}

class _NetworkImageMarkerState extends State<NetworkImageMarker> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(23.872881, 90.380866), zoom: 14.0);
  final List<Marker> _marker = [];

  final List<LatLng> _latLng = [
    const LatLng(23.872881, 90.380866),
    const LatLng(23.876904765072762, 90.36760201451858),
    const LatLng(23.87185280568283, 90.38283706992686),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < _latLng.length; i++) {
      Uint8List? image = await loadNetworkImage(
          "https://static.vecteezy.com/system/resources/thumbnails/002/002/403/small/man-with-beard-avatar-character-isolated-icon-free-vector.jpg");
      final ui.Codec imageMarkerCodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetWidth: 100,
        targetHeight: 100,
      );

      final ui.FrameInfo frameInfo = await imageMarkerCodec.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);

      final Uint8List resizeImageMarker = byteData!.buffer.asUint8List();
      _marker.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          icon: BitmapDescriptor.fromBytes(resizeImageMarker),
          position: _latLng[i],

          infoWindow: InfoWindow(
            title: "Marker Info $i"
          )

        ),
      );
      setState(() {});
    }
  }

  Future<Uint8List?> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);

    image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((info, _) {
      return completer.complete(info);
    }));
    final imageInfo = await completer.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("network image marker"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _cameraPosition,
        markers: Set<Marker>.of(_marker),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
