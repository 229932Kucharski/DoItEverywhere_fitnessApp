import 'package:DIE/widgets/points_page/points_text.dart';
import 'package:flutter/material.dart';
import 'package:DIE/widgets/points_page/points_chart.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background/bg_01.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Your progress',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceCodePro',
                  ),
                ),
                PointsChart(),
                PointsText(),
              ],
            )));
  }
}
