import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserCurrentLocationProvider extends ChangeNotifier {
  Position? _currentLocation;

  Position? get currentLocation => _currentLocation;

  Future<void> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).catchError((error) {
      print("Error: $error");
    });

    _currentLocation = await Geolocator.getCurrentPosition();

    notifyListeners();
  }
}