import 'package:die_app/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

String? chosenActivityName;
Activity? chosenActivity;
List<Activity> activities = [];
bool isRestartNeeded = true;

class ActivityList extends StatefulWidget {
  const ActivityList({Key? key}) : super(key: key);

  @override
  _ActivityListState createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  @override
  void initState() {
    super.initState();
  }

  void setChosenActivity(String? name) {
    for (Activity activity in activities) {
      if (activity.name == name) {
        chosenActivity = activity;
      }
    }
  }

  Future<List?> readFavActivities() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    QueryBuilder<ParseObject> queryUserPoints =
        QueryBuilder<ParseObject>(ParseObject('UserFavAct'))
          ..whereEqualTo('user', currentUser);
    final ParseResponse apiResponse = await queryUserPoints.query();
    List<ParseObject> objects = apiResponse.results as List<ParseObject>;
    if (apiResponse.success) {
      if (objects == null) {
        return [];
      } else {
        return objects[0].get<List>('activities');
      }
    } else {
      return [];
    }
  }

  Future<List<Activity>> readActivities() async {
    if (isRestartNeeded == false) {
      return activities;
    }
    print("czytam aktywnosci");
    isRestartNeeded = false;
    List? favActivitiesNames = await readFavActivities();
    List<Activity> tempActivities = [];
    List<Activity> favActivities = [];
    QueryBuilder<ParseObject> queryActivities =
        QueryBuilder<ParseObject>(ParseObject('Activity'));
    final ParseResponse apiResponse = await queryActivities.query();
    if (apiResponse.success && apiResponse.results != null) {
      List<ParseObject> activityList = apiResponse.results as List<ParseObject>;
      for (ParseObject activity in activityList) {
        String? name = activity.get<String>('Name');
        String? icon = activity.get<String>('icon_name');
        int? points = activity.get<int>('Points');
        bool? isGpsReq = activity.get<bool>('isGpsRequired');
        Activity act = Activity(
            name: name, icon: icon, points: points, isGpsRequired: isGpsReq);
        if (favActivitiesNames!.contains(name)) {
          favActivities.add(act);
          continue;
        } else {
          tempActivities.add(act);
        }
      }
      tempActivities.sort((a, b) => a.name!.compareTo(b.name!));
      for (Activity act in favActivities) {
        tempActivities.insert(0, act);
      }
      activities = tempActivities;
      return activities;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 55, vertical: 30),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2F2F2F),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FutureBuilder<List<Activity>>(
              future: readActivities(),
              builder: (context, snapshot) {
                return DropdownButtonHideUnderline(
                  child: DropdownButton(
                      value: chosenActivityName,
                      isExpanded: true,
                      iconSize: 36,
                      menuMaxHeight: 500.0,
                      items: snapshot.data?.map((Activity map) {
                        return DropdownMenuItem<String>(
                            value: map.name,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(map.name!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'SourceCodePro',
                                    )),
                                ImageIcon(
                                  AssetImage("assets/icons/" + map.icon!),
                                  color: Colors.amber[800],
                                )
                              ],
                            ));
                      }).toList(),
                      onChanged: (value) => setState(() {
                            chosenActivityName = value as String?;
                            setChosenActivity(chosenActivityName);
                          })),
                );
              },
            )));
  }
}
