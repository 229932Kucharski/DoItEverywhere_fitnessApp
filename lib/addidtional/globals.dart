library die_app.globals;

int maxPoints = 100000;
String? username = '';
DateTime? registerDate;

DateTime? loginClickTime;

bool isRedundentClick(DateTime currentTime) {
  if (loginClickTime == null) {
    loginClickTime = currentTime;
    return false;
  }
  if (currentTime.difference(loginClickTime!).inMilliseconds < 1500) {
    //set this difference time in seconds
    return true;
  }

  loginClickTime = currentTime;
  return false;
}
