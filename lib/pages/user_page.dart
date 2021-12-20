import 'package:flutter/material.dart';
import 'package:die_app/addidtional/globals.dart' as globals;

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/bg_03.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // part with avatar //
              Padding(
                padding: const EdgeInsets.only(top: 100.0, bottom: 80.0),
                child: SizedBox(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 90,
                          backgroundColor: Color(0xFFFF9505),
                          child: CircleAvatar(
                            radius: 85,
                            backgroundImage:
                                AssetImage('assets/users/avatar.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Hello ${globals.username}!",
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'SourceCodePro',
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
                              onPressed: () {},
                              child:
                                  const Icon(Icons.contacts_rounded, size: 60),
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
                        Row(
                          children: [
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 30.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Icon(Icons.favorite, size: 50),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(20)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurple[
                                            800]), // <-- Button color
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
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
                                padding: const EdgeInsets.only(
                                    left: 50.0, top: 30.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Icon(Icons.people, size: 40),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(25)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurple[
                                            800]), // <-- Button color
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
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
                              onPressed: () {},
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
                                const EdgeInsets.only(left: 35.0, top: 40.0),
                            child: ElevatedButton(
                              onPressed: () {},
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
