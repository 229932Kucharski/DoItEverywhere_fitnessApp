import 'package:die_app/back4app/login.dart';
import 'package:die_app/widgets/activity_list.dart';
import 'package:die_app/widgets/user_fav_act_list.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

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
      readedActivities = [];
      chosenActivityName = null;
      selectedFav = List.generate(activities.length, (i) => false);
      isRestartNeeded = true;
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
    return ElevatedButton(onPressed: doUserLogout, child: const Text("Logout"));
  }
}
