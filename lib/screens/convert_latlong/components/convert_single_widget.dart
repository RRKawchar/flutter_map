
import 'package:flutter/material.dart';

class ConvertSingleWidget extends StatelessWidget {
  final String setAddress;
  final String setDetails;
  final void Function()? onTap;
  const ConvertSingleWidget({Key? key, required this.setAddress, required this.setDetails, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text(setAddress,style: const TextStyle(fontSize: 20),),
        Text(setDetails,style: const TextStyle(fontSize: 20),),
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.green
              ),
              child: const Center(child: Text("Convert")),
            ),
          ),
        )
      ],
    );
  }
}
