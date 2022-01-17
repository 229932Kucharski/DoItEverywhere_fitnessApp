library DIE.globals;

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
  if (currentTime.difference(loginClickTime!).inMilliseconds < 1500) {
    //set this difference time in seconds
    return true;
  }
  loginClickTime = currentTime;
  return false;
}
