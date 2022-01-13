import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  StatsChart({Key? key}) : super(key: key);

  @override
  StatsChartState createState() => StatsChartState();
}

class StatsChartState extends State<StatsChart> {
  List<_PointsData> data = [
    _PointsData('Mon', 35000),
    _PointsData('Tue', 28000),
    _PointsData('Wed', 34000),
    _PointsData('Thu', 32000),
    _PointsData('Fri', 40000),
    _PointsData('Sat', 50000),
    _PointsData('Sun', 60000)
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Initialize the chart widget
        SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          palette: const [Color(0xFFFF9505)],
          // Enable legend
          legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
          ),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<_PointsData, String>>[
            LineSeries<_PointsData, String>(
              dataSource: data,
              xValueMapper: (_PointsData points, _) => points.year,
              yValueMapper: (_PointsData points, _) => points.points,
              name: 'Your points',
              // Enable data label
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ],
    );
  }
}

class _PointsData {
  _PointsData(this.year, this.points);

  final String year;
  final double points;
}
