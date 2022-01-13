import 'package:die_app/addidtional/route_to_down.dart';
import 'package:die_app/pages/activity/chosen_activity_page.dart';
import 'package:die_app/widgets/activity_page/activity_list.dart';
import 'package:flutter/material.dart';
import 'package:die_app/addidtional/globals.dart' as globals;

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background/bg_02.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Choose activity',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceCodePro',
                  ),
                ),
                const ActivityList(),
                const SizedBox(height: 120),
                ElevatedButton(
                  onPressed: () {
                    if (!globals.isRedundentClick(DateTime.now())) {
                      if (chosenActivity != null) {
                        Navigator.push(
                            context,
                            RouteToDown(
                                exitPage: this,
                                enterPage: const ChosenActivity()));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber[800],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceCodePro',
                    ),
                  ),
                ),
                const SizedBox(height: 150),
              ],
            )));
  }
}
