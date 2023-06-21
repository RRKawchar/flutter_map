import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({Key? key}) : super(key: key);

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final List<Marker> _marker = <Marker>[];
  final List<LatLng> _latLng = <LatLng>[
    const LatLng(23.86838811968793, 90.38599420598435),
    const LatLng(23.865167872845046, 90.396630454088),
    const LatLng(23.872196190745168, 90.38308383314877),
    const LatLng(23.87081280684265, 90.38740754352915),
    const LatLng(23.889526124621188, 90.40050655594375),
    const LatLng(23.86178120462871, 90.35333805892607),
  ];

  static const CameraPosition cameraPosition = CameraPosition(
      target: LatLng(23.86838811968793, 90.38599420598435),
      zoom: 15,
      tilt: 10.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latLng.length; i++) {
      if(i%2==0){
        _marker.add(Marker(
            markerId: MarkerId(i.toString()),
            position: _latLng[i],
            infoWindow: InfoWindow(title: "Marker $i"),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Center(child: CircleAvatar(radius: 30,backgroundColor: Colors.red,),)
                ),
                _latLng[i],
              );
            },
            icon: BitmapDescriptor.defaultMarker));
      }else{
        _marker.add(Marker(
            markerId: MarkerId(i.toString()),
            position: _latLng[i],
            infoWindow: InfoWindow(title: "Marker $i"),
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.red,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                                image: NetworkImage(
                                    'https://img.freepik.com/free-photo/top-view-pepperoni-pizza-with-mushroom-sausages-bell-pepper-olive-corn-black-wooden_141793-2158.jpg?w=2000'))),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  " Mushroom Pizza",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("3m")
                              ],
                            ),
                            Text(
                              "Button Mushrooms. This is the most common type of mushroom and typically the first kind that comes to mind when one thinks of a mushroom.",
                              maxLines: 2,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                _latLng[i],
              );
            },
            icon: BitmapDescriptor.defaultMarker));
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Custom info window"),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: cameraPosition,
              markers: Set<Marker>.of(_marker),
              onMapCreated: (GoogleMapController controller) {
                _customInfoWindowController.googleMapController = controller;
              },
              onTap: (position) {
                _customInfoWindowController.hideInfoWindow!();
              },
              onCameraMove: (position) {
                _customInfoWindowController.onCameraMove!();
              },
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 200,
              width: 300,
              offset: 30,
            )
          ],
        ));
  }
}
