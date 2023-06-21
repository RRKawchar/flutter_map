import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapStyleScreen extends StatefulWidget {
  const GoogleMapStyleScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapStyleScreen> createState() => _GoogleMapStyleScreenState();
}

class _GoogleMapStyleScreenState extends State<GoogleMapStyleScreen> {

  String mapTheme='';
final Completer<GoogleMapController> _controller=Completer();

  final CameraPosition _cameraPosition=const CameraPosition(
      target: LatLng(23.872881, 90.380866),
    zoom: 14.0,
  );


  @override
  void initState() {
    super.initState();
   DefaultAssetBundle.of(context).loadString("assets/map_style/night_theme.json").then((value){
     mapTheme=value;
   });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map Style"),
        actions: [
          PopupMenuButton(
              itemBuilder: (context)=>[

                 PopupMenuItem(
                  onTap: (){

                    _controller.future.then((value){
                      DefaultAssetBundle.of(context).loadString("assets/map_style/sliver_theme.json").then((string){
                        value.setMapStyle(string);

                      });
                    });
                  },
                    child: const Text("Silver")
                ),
                PopupMenuItem(
                    onTap: (){
                      _controller.future.then((value){
                        DefaultAssetBundle.of(context).loadString("assets/map_style/retro_theme.json").then((string){
                          value.setMapStyle(string);

                        });
                      });
                    },
                    child: const Text("Retro")
                ),
                PopupMenuItem(
                    onTap: (){
                      _controller.future.then((value){
                        DefaultAssetBundle.of(context).loadString("assets/map_style/night_theme.json").then((string){
                          value.setMapStyle(string);

                        });
                      });
                    },
                    child: const Text("Night")
                ),
              ]
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _cameraPosition,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller){
          controller.setMapStyle(mapTheme);
             _controller.complete(controller);
        },
      ),
    );
  }
}
