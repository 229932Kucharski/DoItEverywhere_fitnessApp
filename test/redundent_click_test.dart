import 'package:DIE/addidtional/globals.dart' as globals;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Redundent click should be blocked', () {
    globals.loginClickTime = DateTime.now();
    expect(globals.isRedundentClick(DateTime.now()), true);
  });

  test('Click after 1,5s should be able', () {
    globals.loginClickTime =
        DateTime.now().subtract(const Duration(seconds: 2));
    expect(globals.isRedundentClick(DateTime.now()), false);
  });
}
