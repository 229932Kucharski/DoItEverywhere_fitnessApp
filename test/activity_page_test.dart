import 'package:DIE/pages/activity/activity_page.dart';
import 'package:DIE/widgets/activity_page/activity_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('ActivityPage test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: ActivityPage()));

    expect(find.text("Choose activity"), findsOneWidget);
    expect(find.byType(ActivityList), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
