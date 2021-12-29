import 'dart:async';
import 'dart:math' show cos, sqrt, asin;

import 'package:die_app/pages/chosen_activity_page.dart';
import 'package:flutter/material.dart';
import 'package:die_app/widgets/activity_list.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

double totalDistance = 0;
double currentSpeed = 0;

class ActivityLocation extends StatefulWidget {
  final ChosenActivityController controller;
  const ActivityLocation({Key? key, required this.controller})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ActivityLocationState createState() => _ActivityLocationState(controller);
}

class _ActivityLocationState extends State<ActivityLocation> {
  double? lastLongitute;
  double? lastLatitude;
  DateTime? lastTime;

  _ActivityLocationState(ChosenActivityController _controller) {
    _controller.listenLocation = listenLocation;
    _controller.stopLocation = stopListening;
    _controller.resetLastLocation = resetLastLocation;
  }

  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.enableBackgroundMode(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Text("Speed",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'SourceCodePro',
                    fontWeight: FontWeight.bold)),
            (chosenActivity!.isGpsRequired!)
                ? (!currentSpeed.isInfinite)
                    ? Text(currentSpeed.toStringAsFixed(2) + "km/h",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'SourceCodePro',
                          fontStyle: FontStyle.italic,
                        ))
                    : const Text("0.00km/h",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'SourceCodePro',
                          fontStyle: FontStyle.italic,
                        ))
                : const Text("-",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'SourceCodePro',
                      fontStyle: FontStyle.italic,
                    )),
          ],
        ),
        Column(
          children: [
            const Text("Distance",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'SourceCodePro',
                    fontWeight: FontWeight.bold)),
            (chosenActivity!.isGpsRequired!)
                ? Text(totalDistance.toStringAsFixed(2) + "km",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'SourceCodePro',
                      fontStyle: FontStyle.italic,
                    ))
                : const Text("-",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'SourceCodePro',
                      fontStyle: FontStyle.italic,
                    )),
          ],
        )
      ],
    );
  }

  Future<void> listenLocation() async {
    locationSubscription = location.onLocationChanged.handleError((onError) {
      locationSubscription?.cancel();
      setState(() {
        locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      if (lastLatitude == null && lastLongitute == null) {
        lastLatitude = currentlocation.latitude;
        lastLongitute = currentlocation.longitude;
        lastTime = DateTime.now();
      } else {
        double distance = calculateDistance(lastLatitude, lastLongitute,
            currentlocation.latitude, currentlocation.longitude);
        if (distance > 0.1) {
          lastLatitude = currentlocation.latitude;
          lastLongitute = currentlocation.longitude;
          lastTime = DateTime.now();
          return;
        }
        var diff = DateTime.now().difference(lastTime!).inSeconds;
        double diffH = diff / 3600;
        setState(() {
          totalDistance += distance;
          currentSpeed = distance / diffH;
        });
        lastLatitude = currentlocation.latitude;
        lastLongitute = currentlocation.longitude;
        lastTime = DateTime.now();
      }
    });
  }

  stopListening() {
    locationSubscription?.cancel();
  }

  resetLastLocation() {
    lastLongitute = null;
    lastLatitude = null;
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
