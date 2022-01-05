import 'package:die_app/addidtional/route_to_up.dart';
import 'package:die_app/pages/user/user_page.dart';
import 'package:flutter/material.dart';
// import 'package:die_app/addidtional/globals.dart' as globals;

class UserDataPage extends StatelessWidget {
  const UserDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "180 cm\n",
                          style: TextStyle(
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
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "80 kg\n",
                          style: TextStyle(
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
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "24\n",
                          style: TextStyle(
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
                                padding:
                                    const EdgeInsets.only(right: 35, top: 30),
                                child: SizedBox(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //     context,
                                      //     RouteToUp(
                                      //         exitPage: this,
                                      //         enterPage: const UserPage()));
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
                                padding:
                                    const EdgeInsets.only(left: 35, top: 30),
                                child: SizedBox(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //     context,
                                      //     RouteToUp(
                                      //         exitPage: this,
                                      //         enterPage: const UserPage()));
                                    },
                                    child: const Icon(Icons.settings, size: 50),
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
  }
}
