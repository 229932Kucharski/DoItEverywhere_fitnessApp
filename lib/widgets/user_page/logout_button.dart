import 'package:DIE/back4app/login.dart';
import 'package:DIE/pages/home_page.dart';
import 'package:DIE/widgets/activity_page/activity_list.dart';
import 'package:DIE/widgets/points_page/points_chart.dart';
import 'package:DIE/widgets/user_page/user_avatar_widget.dart';
import 'package:DIE/widgets/user_page/user_fav_act_list.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:DIE/addidtional/globals.dart' as globals;

class LogoutButton extends StatefulWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  _LogoutButtonState createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  void doUserLogout() async {
    var response =
        await (await ParseUser.currentUser() as ParseUser?)!.logout();
    if (response.success) {
      // Clear global variables
      selectedFav = List.generate(activities.length, (i) => false);
      readedActivities = [];
      chosenActivityName = null;
      isActivityListRestartNeeded = true;
      isPointsRestartNeeded = true;
      avatarFile = null;
      lastPageIndex = null;
      // Remove until Login Widget
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Login(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        if (!globals.isRedundentClick(DateTime.now())) {doUserLogout()}
      },
      child: const Icon(Icons.logout_outlined, size: 35),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const CircleBorder()),
        padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
        backgroundColor: MaterialStateProperty.all(
            Colors.deepPurple[300]), // <-- Button color
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.amber[800];
            } // <-- Splash color
          },
        ),
      ),
    );
  }
}
