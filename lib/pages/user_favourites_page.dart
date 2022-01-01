import 'package:die_app/models/activity.dart';
import 'package:die_app/widgets/activity_list.dart';
import 'package:die_app/widgets/user_fav_act_list.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:collection/collection.dart';

class UserFavourites extends StatelessWidget {
  const UserFavourites({Key? key}) : super(key: key);

  Future<void> saveFavActivities() async {
    List<String?> favActivity = [];
    print("Zapisywanie fav");
    print(selectedFav);
    for (int i = 0; i < selectedFav.length; i++) {
      if (selectedFav[i] == true) {
        print(activities[i].name);
        favActivity.add(activities[i].name);
      }
    }
    Function eq = const ListEquality().equals;
    if (eq(readedActivities, favActivity)) {
      print("No change in fav activities. Not saving...");
      return;
    }
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    QueryBuilder<ParseObject> queryUserPoints =
        QueryBuilder<ParseObject>(ParseObject('UserFavAct'))
          ..whereEqualTo('user', currentUser);
    final ParseResponse apiResponse = await queryUserPoints.query();
    List<ParseObject> objects = apiResponse.results as List<ParseObject>;
    String? id = objects[0].objectId;
    var parseObject = ParseObject("UserFavAct")
      ..objectId = id
      ..set("activities", favActivity);

    final ParseResponse parseResponse = await parseObject.save();
    if (parseResponse.success) {
      readedActivities = [];
      selectedFav = List.generate(activities.length, (i) => false);
      isRestartNeeded = true;
      print("Saving new fav activities" + favActivity.toString());
    } else {
      print('Object updated with failed: ${parseResponse.error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/bg_03_1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // part with avatar //
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SizedBox(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "Choose your favourites activities",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'SourceCodePro',
                            ),
                          ),
                        ),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () async {
                              await saveFavActivities();
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.favorite, size: 60),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const CircleBorder()),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(40)),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.deepPurple[800]), // <-- Button color
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.amber[800];
                                  } // <-- Splash color
                                },
                              ),
                            ),
                          ),
                        ),
                        const UserFavActList(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}