import 'package:flutter/material.dart';
import 'package:flutter_google_map/src/google_map_style/google_map_style_screen.dart';
import 'package:flutter_google_map/src/network_image_marker/network_image_marker.dart';
import 'package:location/location.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Location().requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location tracking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GoogleMapStyleScreen(),
    );
  }
}


