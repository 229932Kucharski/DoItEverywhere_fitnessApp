import 'package:DIE/back4app/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('LoginPage test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Login()));

    expect(find.text("SIGN IN"), findsOneWidget);
    expect(find.text("SIGN UP"), findsOneWidget);
    expect(find.text("Username"), findsOneWidget);
    expect(find.text("Password"), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));

    await tester.tap(find.byType(TextButton).first);
    await tester.pump();
    expect(find.byType(AlertDialog), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, "TestUser");
    expect(
        find.descendant(
            of: find.byType(TextField).first, matching: find.text("TestUser")),
        findsOneWidget);

    await tester.enterText(find.byType(TextField).last, "qwerty");
    expect(
        find.descendant(
            of: find.byType(TextField).last, matching: find.text("qwerty")),
        findsOneWidget);
  });
}
