import 'package:die_app/addidtional/route_to_up.dart';
import 'package:die_app/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:die_app/addidtional/globals.dart' as globals;

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({Key? key}) : super(key: key);

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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "About ${globals.username}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontFamily: 'SourceCodePro',
                            ),
                          ),
                        ),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  RouteToUp(
                                      exitPage: this,
                                      enterPage: const UserPage()));
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Register date:\n${globals.registerDate?.day.toString()}.${globals.registerDate?.month.toString()}.${globals.registerDate?.year.toString()}\n",
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'SourceCodePro',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Activity distance:\n//do zmiany// ${globals.registerDate?.day.toString()}.${globals.registerDate?.month.toString()}.${globals.registerDate?.year.toString()}\n",
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'SourceCodePro',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Activity time:\n//do zmiany// ${globals.registerDate?.day.toString()}.${globals.registerDate?.month.toString()}.${globals.registerDate?.year.toString()}\n",
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'SourceCodePro',
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Number of activities:\n//do zmiany// ${globals.registerDate?.day.toString()}.${globals.registerDate?.month.toString()}.${globals.registerDate?.year.toString()}\n",
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
            ],
          ),
        ),
      ),
    );
  }
}
