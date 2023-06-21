import 'package:flutter/material.dart';
import 'package:flutter_google_map/src/convert_latlong/components/convert_single_widget.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLongToAddress extends StatefulWidget {
  const ConvertLatLongToAddress({Key? key}) : super(key: key);

  @override
  State<ConvertLatLongToAddress> createState() =>
      _ConvertLatLongToAddressState();
}

class _ConvertLatLongToAddressState extends State<ConvertLatLongToAddress> {
  String setAddress = "";
  String setCountryDetails = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConvertSingleWidget(
              setAddress: setAddress,
              setDetails: setCountryDetails,
              onTap: () async {

                List<Location> locations =await locationFromAddress("Gronausestraat 710, Enschede");
                List<Placemark> placemarks = await placemarkFromCoordinates(24.227918485986653, 90.34017813890053);

                setState(() {
                  setAddress =
                      "${locations.last.longitude} ${locations.last.longitude}";
                  setCountryDetails =
                      "${placemarks.last.country} , ${placemarks.reversed.last.name}";
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
