import 'dart:async';

import 'package:die_app/addidtional/route_to_down.dart';
import 'package:die_app/addidtional/route_to_up.dart';
import 'package:die_app/pages/user/user_page.dart';
import 'package:die_app/pages/user/user_settings_page.dart';
import 'package:die_app/pages/user/user_stats_page.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
// import 'package:die_app/addidtional/globals.dart' as globals;

class UserDataPage extends StatefulWidget {
  const UserDataPage({Key? key}) : super(key: key);

  @override
  _UserDataPageState createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  final controllerHeight = TextEditingController();
  final controllerWeight = TextEditingController();
  final controllerAge = TextEditingController();

  ParseUser? currentUser;
  int? height;
  int? weight;
  int? age;

  Future<ParseUser?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    await getUserInfo();
    return currentUser;
  }

  Future<void> getUserInfo() async {
    QueryBuilder<ParseObject> queryUserData =
        QueryBuilder<ParseObject>(ParseObject('UserData'))
          ..whereEqualTo('user', currentUser);
    final ParseResponse apiResponse = await queryUserData.query();
    if (apiResponse.success && apiResponse.results != null) {
      List<ParseObject> objects = apiResponse.results as List<ParseObject>;
      for (ParseObject object in objects) {
        height = object.get('height');
        weight = object.get('weight');
        age = object.get('age');
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ParseObject?>(
      future: getUser(),
      builder: (context, snapshot) {
        return Scaffold(
          body: SizedBox.expand(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background/bg_02_1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // part with avatar //
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: SizedBox(
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                "Your stats",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'SourceCodePro',
                                ),
                              ),
                            ),
                            SizedBox(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.menu, size: 60),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder()),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(40)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors
                                          .deepPurple[800]), // <-- Button color
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return Colors.amber[800];
                                      } // <-- Splash color
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // part with buttons //
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Height:",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'SourceCodePro',
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "$height cm\n",
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'SourceCodePro',
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Weight:",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'SourceCodePro',
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "$weight kg\n",
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'SourceCodePro',
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Age:",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'SourceCodePro',
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "$age\n",
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'SourceCodePro',
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 35, top: 30),
                                    child: SizedBox(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              RouteToDown(
                                                  exitPage:
                                                      const UserDataPage(),
                                                  enterPage:
                                                      const UserStatsPage()));
                                        },
                                        child: const Icon(
                                            Icons.insert_chart_outlined_sharp,
                                            size: 50),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              const CircleBorder()),
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.all(25)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.deepPurple[
                                                      800]), // <-- Button color
                                          overlayColor: MaterialStateProperty
                                              .resolveWith<Color?>(
                                            (states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return Colors.amber[800];
                                              } // <-- Splash color
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 35, top: 30),
                                    child: SizedBox(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              RouteToDown(
                                                  exitPage:
                                                      const UserDataPage(),
                                                  enterPage:
                                                      const UserSettingsPage()));
                                        },
                                        child: const Icon(Icons.settings,
                                            size: 50),
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              const CircleBorder()),
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.all(25)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.deepPurple[
                                                      800]), // <-- Button color
                                          overlayColor: MaterialStateProperty
                                              .resolveWith<Color?>(
                                            (states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return Colors.amber[800];
                                              } // <-- Splash color
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}