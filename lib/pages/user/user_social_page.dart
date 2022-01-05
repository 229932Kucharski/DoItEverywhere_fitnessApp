import 'package:flutter/material.dart';

import 'package:die_app/addidtional/route_to_down.dart';
import 'package:die_app/pages/user/user_add_friend_page.dart';
import 'package:die_app/pages/user/user_invitations_page.dart';
import 'package:die_app/widgets/user_page/user_friends_list.dart';

class UserSocialPage extends StatelessWidget {
  const UserSocialPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background/bg_02_1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // part with avatar //
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "Social page",
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
                            child: const Icon(Icons.people, size: 60),
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
                      ],
                    ),
                  ),
                ),
              ),

              // part with buttons //
              const Expanded(
                child: UserFriendsList(),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 55, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, //Center Row contents horizontally,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 35, top: 30),
                          child: SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    RouteToDown(
                                        exitPage: this,
                                        enterPage:
                                            const UserInvitationsPage()));
                              },
                              child: const Icon(Icons.groups, size: 50),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 35, top: 30),
                          child: SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    RouteToDown(
                                        exitPage: this,
                                        enterPage: const UserAddFriendPage()));
                              },
                              child:
                                  const Icon(Icons.group_add_rounded, size: 50),
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
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
