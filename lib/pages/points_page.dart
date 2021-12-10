import 'package:flutter/material.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background/bg_01.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: null /* add child content here */,
    ));
  }
}
