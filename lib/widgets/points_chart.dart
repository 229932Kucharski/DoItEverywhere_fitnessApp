import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

int? points;

class PointsChart extends StatefulWidget {
  const PointsChart({Key? key}) : super(key: key);

  @override
  _PointsChartState createState() => _PointsChartState();
}

class _PointsChartState extends State<PointsChart> {
  late TooltipBehavior _tooltipBehavior;

  ParseUser? currentUser;

  Future<ParseObject?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    QueryBuilder<ParseObject> queryUserPoints =
        QueryBuilder<ParseObject>(ParseObject('UserData'))
          ..whereEqualTo('user', currentUser);
    final ParseResponse apiResponse = await queryUserPoints.query();
    if (apiResponse.success) {
      List<ParseObject> objects = apiResponse.results as List<ParseObject>;
      DateTime updatedAt =
          DateTime.parse((objects[0].get('pointsUpdatedAt')).toString());
      int diff = DateTime.now().difference(updatedAt).inDays;
      if (diff > 0) {
        int pointsToRemove = diff * 10000;
        int currentPoints = objects[0].get('points');
        currentPoints = currentPoints - pointsToRemove;
        if (currentPoints < 0) currentPoints = 0;
        await updateUser(currentPoints);
        QueryBuilder<ParseObject> queryUserPoints =
            QueryBuilder<ParseObject>(ParseObject('UserData'))
              ..whereEqualTo('user', currentUser);
        final ParseResponse apiResponse = await queryUserPoints.query();
        if (apiResponse.success) {
          objects = apiResponse.results as List<ParseObject>;
        }
      }
      points = objects[0].get('points');
      return objects[0];
    } else {
      showError(apiResponse.error!.message);
    }
    return null;
  }

  Future<void> updateUser(int points) async {
    String? id;
    QueryBuilder<ParseObject> queryUserPoints =
        QueryBuilder<ParseObject>(ParseObject('UserData'))
          ..whereEqualTo('user', currentUser);
    final ParseResponse apiResponse = await queryUserPoints.query();

    List<ParseObject> objects = apiResponse.results as List<ParseObject>;
    for (ParseObject object in objects) {
      id = object.objectId;
    }
    var user = ParseObject('UserData')
      ..objectId = id
      ..set('points', points)
      ..set('pointsUpdatedAt', DateTime.now());
    await user.save();
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  List<double> stops = <double>[
    0.2,
    0.4,
    0.6,
    0.8,
    1,
  ];
  List<Color> colors = <Color>[
    const Color(0xFFCC5803),
    const Color(0xFFE2711D),
    const Color(0xFFFF9505),
    const Color(0xFFFFB627),
    const Color(0xFFFFC971),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ParseObject?>(
        future: getUser(),
        builder: (context, snapshot) {
          return SfCircularChart(
            onCreateShader: (ChartShaderDetails chartShaderDetails) {
              return ui.Gradient.sweep(
                  chartShaderDetails.outerRect.center,
                  colors,
                  stops,
                  TileMode.clamp,
                  _degreeToRadian(0),
                  _degreeToRadian(360),
                  _resolveTransform(
                      chartShaderDetails.outerRect, TextDirection.ltr));
            },
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              RadialBarSeries<PointsData, String>(
                  maximumValue: 100000,
                  radius: '100%',
                  innerRadius: '65%',
                  gap: '10',
                  trackOpacity: 0.2,
                  cornerStyle: CornerStyle.bothCurve,
                  dataSource: [
                    PointsData('Month', snapshot.data?.get('points')),
                  ],
                  xValueMapper: (PointsData data, _) => data.range,
                  yValueMapper: (PointsData data, _) => data.points,
                  dataLabelMapper: (PointsData data, _) => data.range,
                  dataLabelSettings: const DataLabelSettings(
                      isVisible: false,
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontFamily: 'SourceCodePro',
                      ),
                      labelAlignment: ChartDataLabelAlignment.outer),
                  enableTooltip: true)
            ],
          );
        });
  }

  // Rotate the sweep gradient according to the start angle
  Float64List _resolveTransform(Rect bounds, TextDirection textDirection) {
    final GradientTransform transform = GradientRotation(_degreeToRadian(-90));
    return transform.transform(bounds, textDirection: textDirection)!.storage;
  }

  // Convert degree to radian
  double _degreeToRadian(int deg) => deg * (3.141592653589793 / 180);

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
              "Some error occured! Please check your internet connection and try again"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class PointsData {
  PointsData(this.range, this.points);
  final String range;
  final int? points;
}
