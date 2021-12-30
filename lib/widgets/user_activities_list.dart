import 'package:die_app/models/user_activity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserActivitiesList extends StatefulWidget {
  const UserActivitiesList({Key? key}) : super(key: key);

  @override
  _UserActivitiesListState createState() => _UserActivitiesListState();
}

class _UserActivitiesListState extends State<UserActivitiesList> {
  ParseUser? currentUser;

  Future<List<UserActivity>>? getUserActivities() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    QueryBuilder<ParseObject> queryUserPoints =
        QueryBuilder<ParseObject>(ParseObject('UserActivity'))
          ..whereEqualTo('userId', currentUser);
    final ParseResponse apiResponse = await queryUserPoints.query();
    List<UserActivity> userActivities = [];
    if (apiResponse.success) {
      List<ParseObject> activities = apiResponse.results as List<ParseObject>;
      for (ParseObject activity in activities) {
        String? name = activity.get<String>('activityName');
        DateTime? date = activity.get<DateTime>('createdAt');
        num? duration = activity.get<num>('activityTime');
        num? distance = activity.get<num>('activityDistance');
        String? icon = activity.get<String>('activityIcon');
        date = date!.toLocal();
        var format = DateFormat.yMd();
        var dateString = format.format(date);
        format = DateFormat.Hm();
        var endTime = format.format(date);
        date = date.subtract(Duration(seconds: duration!.toInt()));
        var startTime = format.format(date);
        UserActivity userActivity = UserActivity(
            name: name,
            date: dateString,
            startTime: startTime,
            endTime: endTime,
            duration: duration,
            distance: distance,
            activityIcon: icon);
        userActivities.add(userActivity);
      }
    } else {
      print(apiResponse.error!.message);
    }
    userActivities = userActivities.reversed.toList();
    return userActivities;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserActivity>>(
      future: getUserActivities(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 10),
            child: SizedBox(
              height: 420,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff333333),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 4),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 15, right: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(snapshot.data![index].date!),
                                    Text((snapshot.data![index].distance! > 0)
                                        ? (snapshot.data![index].distance!
                                                .toString() +
                                            "km")
                                        : ""),
                                  ],
                                ),
                                ListTile(
                                  isThreeLine: false,
                                  leading: ImageIcon(
                                    AssetImage("assets/icons/" +
                                        snapshot.data![index].activityIcon!),
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  title: Text(snapshot.data![index].name!),
                                  subtitle: Text(
                                    snapshot.data![index].startTime! +
                                        "-" +
                                        snapshot.data![index].endTime!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
