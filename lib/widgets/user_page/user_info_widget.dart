import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:die_app/addidtional/globals.dart' as globals;

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfoWidget> {
  double activityDistance = 0;
  double activityTime = 0;
  int numOfActivities = 0;
  String registerDate = "";
  Future<bool>? getUserActivityStats() async {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    registerDate = formatter.format(globals.registerDate!);
    activityDistance = 0;
    activityTime = 0;
    numOfActivities = 0;
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    QueryBuilder<ParseObject> queryUserActivities =
        QueryBuilder<ParseObject>(ParseObject('UserActivity'))
          ..whereEqualTo('userId', currentUser);

    final ParseResponse apiResponse = await queryUserActivities.query();
    if (apiResponse.success) {
      List<ParseObject> activities = apiResponse.results as List<ParseObject>;
      for (ParseObject activity in activities) {
        numOfActivities++;
        activityTime += activity.get("activityTime");
        activityDistance += activity.get("activityDistance");
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getUserActivityStats(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Register date:",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'SourceCodePro',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          registerDate,
                          style: const TextStyle(
                              fontSize: 25,
                              fontFamily: 'SourceCodePro',
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Total distance:",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'SourceCodePro',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          activityDistance.toString() + "km",
                          style: const TextStyle(
                              fontSize: 25,
                              fontFamily: 'SourceCodePro',
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Total Time:",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'SourceCodePro',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          (activityTime ~/ 3600).toString() +
                              "h " +
                              (activityTime ~/ 60).toString() +
                              "m " +
                              (activityTime % 60).toInt().toString() +
                              "s",
                          style: const TextStyle(
                              fontSize: 25,
                              fontFamily: 'SourceCodePro',
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Number of activities:",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'SourceCodePro',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          numOfActivities.toString(),
                          style: const TextStyle(
                              fontSize: 25,
                              fontFamily: 'SourceCodePro',
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Padding(
            padding: const EdgeInsets.only(
                left: 60, right: 60, top: 120, bottom: 10),
            child: Column(
              children: const [
                Text(
                  'No data available',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceCodePro',
                  ),
                ),
                SizedBox(
                  height: 115,
                )
              ],
            ),
          );
        }
        return Column(children: const [
          SizedBox(
            height: 130,
          ),
          CircularProgressIndicator(),
          SizedBox(
            height: 159,
          )
        ]);
      },
    );
  }
}
