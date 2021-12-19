import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:die_app/widgets/activity_timer.dart';
import 'package:die_app/widgets/activity_list.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ChosenActivity extends StatefulWidget {
  const ChosenActivity({
    Key? key,
  }) : super(key: key);

  @override
  _ChosenActivityState createState() => _ChosenActivityState();
}

class _ChosenActivityState extends State<ChosenActivity> {
  bool isStop = true;
  bool isPlay = false;
  int seconds = 0;

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: const [
                      Text("Speed",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'SourceCodePro',
                              fontWeight: FontWeight.bold)),
                      Text("0,00km/h",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'SourceCodePro',
                            fontStyle: FontStyle.italic,
                          ))
                    ],
                  ),
                  Column(
                    children: const [
                      Text("Distance",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'SourceCodePro',
                              fontWeight: FontWeight.bold)),
                      Text("0m",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'SourceCodePro',
                              fontStyle: FontStyle.italic))
                    ],
                  )
                ],
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
                height: 100,
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
                    },
                    icon: ImageIcon(
                      const AssetImage("assets/icons/play.png"),
                      size: 50,
                      color: isPlay == true ? Colors.amber[800] : Colors.white,
                    ),
                  ),
                  (!isPlay)
                      ? IconButton(
                          onPressed: isStop
                              ? () async {
                                  getTime();
                                  if (await confirm(context)) {
                                    stopWatchTimer.onExecute
                                        .add(StopWatchExecute.reset);
                                    Navigator.pop(context);
                                  }
                                }
                              : null,
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
                      stopWatchTimer.onExecute.add(StopWatchExecute.stop);
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
    super.dispose();
  }
}
