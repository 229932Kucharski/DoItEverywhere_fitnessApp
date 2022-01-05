import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

var stopWatchTimer = StopWatchTimer(
  mode: StopWatchMode.countUp,
);

class ActivityTimer extends StatefulWidget {
  const ActivityTimer({Key? key}) : super(key: key);

  @override
  _ActivityTimerState createState() => _ActivityTimerState();
}

class _ActivityTimerState extends State<ActivityTimer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: stopWatchTimer.rawTime,
      initialData: 0,
      builder: (context, snap) {
        final value = snap.data;
        final displayTime = StopWatchTimer.getDisplayTime(value!);
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                displayTime,
                style: const TextStyle(
                    fontSize: 40,
                    fontFamily: 'SourceCodePro',
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        );
      },
    );
  }
}
