import 'package:die_app/widgets/user_page/user_avatar_widget.dart';
import 'package:flutter/material.dart';

import 'package:die_app/addidtional/globals.dart' as globals;
import 'package:die_app/addidtional/route_to_down.dart';
import 'package:die_app/pages/user/user_data_page.dart';
import 'package:die_app/pages/user/user_favourites_page.dart';
import 'package:die_app/pages/user/user_history_page.dart';
import 'package:die_app/pages/user/user_info_page.dart';
import 'package:die_app/pages/user/user_social_page.dart';
import 'package:die_app/widgets/user_page/logout_button.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/bg_03.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: const [
                      LogoutButton(),
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SourceCodePro',
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            // part with avatar //
            const UserAvatarWidget(),

            // part with buttons //
            SizedBox(
              width: 350.0,
              height: 300.0,
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              if (!globals.isRedundentClick(DateTime.now())) {
                                Navigator.push(
                                    context,
                                    RouteToDown(
                                        exitPage: this,
                                        enterPage: const UserInfoPage()));
                              }
                            },
                            child: const Icon(Icons.contacts_rounded, size: 60),
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
                      ),
                      Row(
                        children: [
                          SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 30.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!globals
                                      .isRedundentClick(DateTime.now())) {
                                    Navigator.push(
                                        context,
                                        RouteToDown(
                                            exitPage: this,
                                            enterPage: const UserFavourites()));
                                  }
                                },
                                child: const Icon(Icons.favorite, size: 50),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder()),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(20)),
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
                          ),
                          SizedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 50.0, top: 30.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!globals
                                      .isRedundentClick(DateTime.now())) {
                                    Navigator.push(
                                        context,
                                        RouteToDown(
                                            exitPage: this,
                                            enterPage: const UserSocialPage()));
                                  }
                                },
                                child: const Icon(Icons.people, size: 40),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder()),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(25)),
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
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (!globals.isRedundentClick(DateTime.now())) {
                                Navigator.push(
                                    context,
                                    RouteToDown(
                                        exitPage: this,
                                        enterPage: const UserHistoryPage()));
                              }
                            },
                            child: const Icon(Icons.history, size: 40),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const CircleBorder()),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(25)),
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
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35.0, top: 40.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (!globals.isRedundentClick(DateTime.now())) {
                                Navigator.push(
                                    context,
                                    RouteToDown(
                                        exitPage: this,
                                        enterPage: const UserDataPage()));
                              }
                            },
                            child: const Icon(Icons.menu, size: 30),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const CircleBorder()),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(15)),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
