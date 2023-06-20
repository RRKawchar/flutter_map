import 'package:flutter/material.dart';
import 'package:flutter_google_map/screens/user_current_location/user_current_location.dart';
import 'package:location/location.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Location().requestPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location tracking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserCurrentLocation(),
    );
  }
}


