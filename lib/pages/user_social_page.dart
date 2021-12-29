import 'package:die_app/addidtional/route_to_up.dart';
import 'package:die_app/pages/user_page.dart';
import 'package:flutter/material.dart';
// import 'package:die_app/addidtional/globals.dart' as globals;

class UserSocialPage extends StatelessWidget {
  const UserSocialPage({Key? key}) : super(key: key);

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
                              Navigator.push(
                                  context,
                                  RouteToUp(
                                      exitPage: this,
                                      enterPage: const UserPage()));
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
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 300.0,
                        height: 300.0,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(columns: [
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.amber[800]),
                            )),
                            DataColumn(
                                label: Text(
                              'Points',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.amber[800]),
                            )),
                          ], rows: const [
                            DataRow(cells: [
                              DataCell(Text('Adam Nowak')),
                              DataCell(Text('30')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Dawid Nowy')),
                              DataCell(Text('21')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Andrzej Konieczny')),
                              DataCell(Text('29')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Jacek Piekarz')),
                              DataCell(Text('29')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Tomek Szybki')),
                              DataCell(Text('29')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Tomek Szybki')),
                              DataCell(Text('29')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Tomek Szybki')),
                              DataCell(Text('29')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Tomek Szybki')),
                              DataCell(Text('29')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Tomek Szybki')),
                              DataCell(Text('29')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Tomek Szybki')),
                              DataCell(Text('29')),
                            ]),
                          ]),
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
                                      Navigator.push(
                                          context,
                                          RouteToUp(
                                              exitPage: this,
                                              enterPage: const UserPage()));
                                    },
                                    child: const Icon(Icons.groups, size: 50),
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
                                      Navigator.push(
                                          context,
                                          RouteToUp(
                                              exitPage: this,
                                              enterPage: const UserPage()));
                                    },
                                    child: const Icon(Icons.group_add_rounded,
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
  }
}
