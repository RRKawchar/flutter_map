import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GoogleSearchPlace extends StatefulWidget {
  const GoogleSearchPlace({Key? key}) : super(key: key);

  @override
  State<GoogleSearchPlace> createState() => _GoogleSearchPlaceState();
}

class _GoogleSearchPlaceState extends State<GoogleSearchPlace> {
  final _uuid = const Uuid();
  String _userToken = "";
  TextEditingController searchController = TextEditingController();

  List<dynamic> _placesList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_userToken.isEmpty) {
      setState(() {
        _userToken = _uuid.v4();
      });
    }

    getSuggestion(searchController.text);
  }

  void getSuggestion(String input) async {
    String apiKey = "AIzaSyCCPy9y0WLD6mmG5IPe7bOvXW5xeJhBWOw";

    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$apiKey&sessiontoken=$_userToken';

    var response=await http.get(Uri.parse(request));
       print(response.body.toString());
    if(response.statusCode==200){
      setState(() {
        _placesList=jsonDecode(response.body.toString())['predictions'];
      });
    }else{
      throw Exception("Failed to Load Data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Search Place"),
        elevation: 0,
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: "Search your location"
              ),
            )
          ],
        ),
      ),
    );
  }
}
