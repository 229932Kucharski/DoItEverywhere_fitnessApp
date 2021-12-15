import 'package:die_app/widgets/points_chart.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Your progress',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceCodePro',
                  ),
                ),
                PointsChart(),
                Text(
                  'Wow! Keep it up!',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'SourceCodePro',
                  ),
                ),
              ],
            )));
  }
}
