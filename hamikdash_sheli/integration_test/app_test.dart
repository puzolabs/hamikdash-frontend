import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:hamikdash_sheli/main.dart';
import 'package:hamikdash_sheli/calApi/cal_api.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('test get availability REST call', (WidgetTester tester) async {
      calApi api = calApi();
      DateTime now = DateTime.now().toUtc();
      await api.getAvailability("http", "10.0.2.2", 3000, "bet-hamikdash", "minha", now, "2024-10-31T20:59:59.999Z", "Asia/Jerusalem");
    });

    testWidgets('tap on the floating action button, verify counter', (tester) async {
      // Load app widget.
      await tester.pumpWidget(const MyApp());

      // Verify the counter starts at 0.
      expect(find.text('0'), findsOneWidget);

      // Finds the floating action button to tap on.
      final fab = find.byKey(const ValueKey('increment'));

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the counter increments by 1.
      expect(find.text('1'), findsOneWidget);
    });
  });
}