library DIE.globals;

import 'package:flutter/material.dart';

int maxPoints = 100000;
String? username = '';
DateTime? registerDate;

DateTime? loginClickTime;

// Check if button click is redundent by diff time
bool isRedundentClick(DateTime currentTime) {
  if (loginClickTime == null) {
    loginClickTime = currentTime;
    return false;
  }
  if (currentTime.difference(loginClickTime!).inMilliseconds < 1200) {
    //set this difference time in seconds
    return true;
  }
  loginClickTime = currentTime;
  return false;
}

// Show error alert
void showError(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Error!"),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
              onPressed: () => {
                    Navigator.pop(context),
                  },
              child: const Text("Ok"))
        ],
      );
    },
  );
}
