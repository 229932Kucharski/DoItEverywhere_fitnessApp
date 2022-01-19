import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  StatsChart({Key? key}) : super(key: key);

  @override
  StatsChartState createState() => StatsChartState();
}

class StatsChartState extends State<StatsChart> {
  ParseUser? currentUser;
  List<int> points = [0, 0, 0, 0, 0, 0, 0];
  List<String> dates = [];
  var format = DateFormat.yMd();
  List<_PointsData> data = [];

  Future<ParseUser?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> getUserPoints() async {
    await getUser();
    for (int i = 6; i >= 0; i--) {
      dates.add(format.format(DateTime.now().subtract(Duration(days: i))));
    }
    QueryBuilder<ParseObject> queryUserData =
        QueryBuilder<ParseObject>(ParseObject('UserActivity'))
          ..whereEqualTo('userId', currentUser)
          ..whereGreaterThan(
              'createdAt', DateTime.now().subtract(const Duration(days: 7)));
    final ParseResponse apiResponse = await queryUserData.query();
    if (apiResponse.success && apiResponse.results != null) {
      List<ParseObject> objects = apiResponse.results as List<ParseObject>;
      for (ParseObject object in objects) {
        int index = dates.indexWhere((element) =>
            element.compareTo(format.format(object.get('createdAt'))) == 0);
        if (index == -1) continue;
        points[index] += object.get<int>('gainedPoints')!;
      }
      addPointsAndDates();
    }
  }

  Future<void> addPointsAndDates() async {
    for (int i = 0; i < 7; i++) {
      data.add(_PointsData(dates[i].toString(), points[i].toDouble()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: getUserPoints(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: [
              //Initialize the chart widget
              SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                palette: const [Color(0xFFFF9505)],
                // Enable legend
                legend: Legend(
                  isVisible: true,
                  toggleSeriesVisibility: false,
                  position: LegendPosition.bottom,
                ),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_PointsData, String>>[
                  ColumnSeries<_PointsData, String>(
                    animationDuration: 2000,
                    dataSource: data,
                    xValueMapper: (_PointsData points, _) => points.day,
                    yValueMapper: (_PointsData points, _) => points.points,
                    name: 'Your points',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Column(
            children: const [
              Text("Check your internet conncetion"),
              SizedBox(
                height: 130,
              ),
              CircularProgressIndicator(),
            ],
          );
        } else {
          return Column(
            children: const [
              Text("Please wait"),
              SizedBox(
                height: 130,
              ),
              CircularProgressIndicator(),
            ],
          );
        }
      },
    );
  }
}

class _PointsData {
  _PointsData(this.day, this.points);

  final String day;
  final double points;
}
