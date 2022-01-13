import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:die_app/widgets/points_page/points_chart.dart';

class PointsText extends StatefulWidget {
  const PointsText({Key? key}) : super(key: key);

  @override
  _PointsTextState createState() => _PointsTextState();
}

class _PointsTextState extends State<PointsText> {
  Future<String> getText() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (points == null) {
      return "";
    }
    if (points == 100000) {
      return "Wow 100%";
    } else if (points! > 95000) {
      return "Almost 100%";
    } else if (points! > 90000) {
      return "You're doing well!";
    } else if (points! > 70000) {
      return "Dont't stop!";
    } else if (points! > 50000) {
      return "Don't let the points drop";
    } else if (points! > 30000) {
      return "You can be better";
    } else if (points! > 10000) {
      return "Not so bad";
    } else if (points! > 0) {
      return "Could be better";
    } else if (points == 0) {
      return "It's time to move and gain some points";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getText(),
        builder: (context, snapshot) {
          return SizedBox(
            height: 100,
            width: 350,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'SourceCodePro',
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  (snapshot.hasData)
                      ? TyperAnimatedText(snapshot.data!,
                          textAlign: TextAlign.center)
                      : TyperAnimatedText(""),
                ],
              ),
            ),
          );
        });
  }
}
