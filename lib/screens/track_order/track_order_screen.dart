import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({Key? key}) : super(key: key);

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
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
      zoom: 13.5);


  final List<Marker> _marker=[];
  final List<Marker> _list=[

    const Marker(
        markerId: MarkerId('1'),
      position: LatLng(23.862722386195372, 90.38553231014907),
      infoWindow: InfoWindow(
        title: "My Current Location"
      )
    ),
    const Marker(
        markerId: MarkerId('2'),
        position:LatLng(23.867675452935778, 90.40623694971248),
        infoWindow: InfoWindow(
            title: "second location"
        )
    ),
    const Marker(
        markerId: MarkerId('3'),
        position:LatLng(23.725350542628732, 90.41184248106987),
        infoWindow: InfoWindow(
            title: "third location"
        )
    ),
    const Marker(
        markerId: MarkerId('4'),
        position:LatLng(23.77715892323534, 90.36955865498737),
        infoWindow: InfoWindow(
            title: "fourth location"
        )
    ),
  ];

  @override
  void initState() {
    super.initState();

    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Order"),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_marker)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{

          GoogleMapController controller=await _controller.future;

          controller.animateCamera(CameraUpdate.newCameraPosition(
              const CameraPosition(
                  target: LatLng(23.870987364240886, 90.38854443394429),
                zoom: 14.0
              )

          ));
          setState(() {

          });
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
