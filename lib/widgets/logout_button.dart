import 'package:die_app/back4app/login.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class LogoutButton extends StatefulWidget {
  LogoutButton({Key? key}) : super(key: key);

  @override
  _LogoutButtonState createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  void doUserLogout() async {
    var response =
        await (await ParseUser.currentUser() as ParseUser?)!.logout();
    if (response.success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Login(),
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
