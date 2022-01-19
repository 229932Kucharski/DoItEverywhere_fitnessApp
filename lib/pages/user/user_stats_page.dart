import 'package:DIE/widgets/user_page/stats_chart.dart';
import 'package:flutter/material.dart';
import 'package:DIE/addidtional/globals.dart' as globals;

class UserStatsPage extends StatelessWidget {
  const UserStatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/bg_01_1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // part with avatar //
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: SizedBox(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              "Your week score",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'SourceCodePro',
                              ),
                            ),
                          ),
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                if (!globals.isRedundentClick(DateTime.now())) {
                                  Navigator.pop(context);
                                }
                              },
                              child: const Icon(Icons.history, size: 60),
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
                        ],
                      ),
                    ),
                  ),
                ),

                // part with buttons //
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: StatsChart(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
