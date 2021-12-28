import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:die_app/widgets/activity_location.dart';
import 'package:die_app/widgets/activity_timer.dart';
import 'package:die_app/widgets/activity_list.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ChosenActivityController {
  late void Function() listenLocation;
  late void Function() stopLocation;
  late void Function() resetLastLocation;
}

class ChosenActivity extends StatefulWidget {
  const ChosenActivity({
    Key? key,
  }) : super(key: key);

  @override
  _ChosenActivityState createState() => _ChosenActivityState();
}

class _ChosenActivityState extends State<ChosenActivity> {
  final ChosenActivityController myController = ChosenActivityController();
  ParseUser? currentUser;
  bool isStop = true;
  bool isPlay = false;
  int seconds = 0;
  int points = 0;

  Future<ParseUser?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> updateUser() async {
    String? id;
    int? currentPoints;
    QueryBuilder<ParseObject> queryUserPoints =
        QueryBuilder<ParseObject>(ParseObject('UserData'))
          ..whereEqualTo('user', currentUser);
    final ParseResponse apiResponse = await queryUserPoints.query();

    List<ParseObject> objects = apiResponse.results as List<ParseObject>;
    for (ParseObject object in objects) {
      id = object.objectId;
      currentPoints = object.get('points');
    }
    var user = ParseObject('UserData')
      ..objectId = id
      ..set('points', currentPoints! + points);
    await user.save();
  }

  Future<void> saveData() async {
    await getUser();
    double distance = double.parse((totalDistance).toStringAsFixed(2));
    final userActivity = ParseObject('UserActivity')
      ..set("userId", currentUser)
      ..set('activityName', chosenActivityName)
      ..set('activityTime', seconds)
      ..set('activityDistance', distance)
      ..set('gainedPoints', points);
    await userActivity.save();
  }

  void getTime() {
    seconds = stopWatchTimer.secondTime.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/bg_02_1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
              const Text("Your activity",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'SourceCodePro',
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 15,
              ),
              ImageIcon(
                AssetImage("assets/icons/" + chosenActivity!.icon!),
                color: Colors.amber[800],
                size: 100,
              ),
              Text(chosenActivity!.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'SourceCodePro',
                    fontStyle: FontStyle.italic,
                  )),
              const SizedBox(
                height: 50,
              ),
              ActivityLocation(
                controller: myController,
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: const [
                  Text("Time",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'SourceCodePro',
                          fontWeight: FontWeight.bold)),
                  ActivityTimer(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              (isStop && seconds > 0)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            int minutes = seconds ~/ 60;
                            points = minutes * chosenActivity!.points!;
                            stopWatchTimer.onExecute
                                .add(StopWatchExecute.reset);
                            await saveData();
                            await updateUser();
                            totalDistance = 0;
                            Navigator.pop(context);
                          },
                          iconSize: 60,
                          icon: ImageIcon(
                            const AssetImage("assets/icons/plus.png"),
                            color: Colors.amber[800],
                          ),
                        ),
                        const Text("Add points",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'SourceCodePro',
                                fontWeight: FontWeight.bold))
                      ],
                    )
                  : const SizedBox(
                      height: 75,
                    ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: (!isPlay)
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        isPlay = true;
                        isStop = false;
                      });
                      stopWatchTimer.onExecute.add(StopWatchExecute.start);
                      (chosenActivity?.isGpsRequired == true)
                          ? myController.listenLocation()
                          : null;
                    },
                    icon: ImageIcon(
                      const AssetImage("assets/icons/play.png"),
                      size: 50,
                      color: isPlay == true ? Colors.amber[800] : Colors.white,
                    ),
                  ),
                  (!isPlay)
                      ? IconButton(
                          onPressed: () async {
                            getTime();
                            if (await confirm(context)) {
                              stopWatchTimer.onExecute
                                  .add(StopWatchExecute.reset);
                              totalDistance = 0;
                              Navigator.pop(context);
                            }
                          },
                          icon: const ImageIcon(
                            AssetImage("assets/icons/cross.png"),
                            size: 100,
                          ),
                        )
                      : const SizedBox(
                          width: 48,
                        ),
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        isPlay = false;
                        isStop = true;
                      });
                      getTime();
                      stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                      (chosenActivity?.isGpsRequired == true)
                          ? {
                              myController.stopLocation(),
                              myController.resetLastLocation()
                            }
                          : null;
                    },
                    icon: ImageIcon(
                      const AssetImage("assets/icons/pause.png"),
                      color: isStop == true ? Colors.amber[800] : Colors.white,
                      size: 100,
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }

  @override
  void dispose() async {
    myController.stopLocation();
    super.dispose();
  }
}
