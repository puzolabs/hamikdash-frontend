import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:parameterized_test/parameterized_test.dart';

import 'package:hamikdash_sheli/calApi/cal_api.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // this test can work ONLY as an intergration test. can't work as unit test (get connection problems sometimes)
  parameterizedTest(
    'test get availability REST call',
    [
      [1, 1],
      [2, 2],
      [3, 3],
      [7, 6], // for a request of 7 days range I expect to get 6 days availability since for Saturday we don't return time slots
    ],
    (int days, int expectedDays) async {
      CalApi api = CalApi();
      DateTime start = DateTime.now();
      DateTime end = start.add(Duration(days: days));
      var list = await api.getAvailability("http", "10.0.2.2", 3000, "bet-hamikdash", "minha", start, end, "Asia/Jerusalem");
      expect(list.length, expectedDays);
    },
  );

  group('end-to-end test', () {
    testWidgets("test getting availabilities of the past in Cal's server", (WidgetTester tester) async {
      CalApi api = CalApi();
      DateTime start = DateTime.parse("2024-10-31T12:00:00.000Z");
      DateTime end = DateTime.parse("2024-10-31T12:15:00.000Z");
      var list = await api.getAvailability("http", "10.0.2.2", 3000, "bet-hamikdash", "minha", start, end, "Asia/Jerusalem");
      expect(list.length, 0);
    });

    testWidgets("test creating an event in Cal's server", (WidgetTester tester) async {
      CalApi api = CalApi();
      DateTime start = DateTime.parse("2024-10-31T12:00:00.000Z");
      DateTime end = DateTime.parse("2024-10-31T12:15:00.000Z");
      var uid = await api.create("http", "10.0.2.2", 3000, "bet-hamikdash", "minha", 4, start, end, "Asia/Jerusalem", "aaa", "aaa@bbb.com");
      expect(uid, isNotNull);
      expect(uid, isNotEmpty);
    });

    testWidgets("test rescheduling an event in Cal's server", (WidgetTester tester) async {
      CalApi api = CalApi();
      DateTime start = DateTime.parse("2024-10-31T12:00:00.000Z");
      DateTime end = DateTime.parse("2024-10-31T12:15:00.000Z");
      var uid = await api.create("http", "10.0.2.2", 3000, "bet-hamikdash", "minha", 4, start, end, "Asia/Jerusalem", "aaa", "aaa@bbb.com");
      expect(uid, isNotNull);
      expect(uid, isNotEmpty);

      start = start.add(const Duration(hours: 1));
      end = end.add(const Duration(hours: 1));
      var uid2 = await api.create("http", "10.0.2.2", 3000, "bet-hamikdash", "minha", 4, start, end, "Asia/Jerusalem", "aaa", "aaa@bbb.com", rescheduleUid: uid);
      expect(uid2, isNotNull);
      expect(uid2, isNotEmpty);
      expect(uid2, isNot(equals(uid)));
    });

    /* a test to simulate this scenario: (double booking)
      - user A sees available time slots
      - user B sees the same available time slots and selects one of them
      - user A selects the same time slot
      expected result is that user A sees an error message and the page controls are cleared in order to get the new available time slots
    */
    testWidgets("test double booking in Cal's server", (WidgetTester tester) async {
      CalApi api = CalApi();
      DateTime start = DateTime.parse("2025-01-12T13:15:00.000Z");
      DateTime end = DateTime.parse("2025-01-12T13:30:00.000Z");
      var uid = await api.create("http", "10.0.2.2", 3000, "bet-hamikdash", "minha", 4, start, end, "Asia/Jerusalem", "aaa", "aaa@bbb.com");
      expect(uid, isNotNull);
      expect(uid, isNotEmpty);
      expect(
        () async => await api.create("http", "10.0.2.2", 3000, "bet-hamikdash", "minha", 4, start, end, "Asia/Jerusalem", "aaa", "aaa@bbb.com"),
        //throwsA(isException));
        //throwsException);
        throwsA(predicate((e) => e is ArgumentError && e.message == 'Time slot is taken')));
    });

    /* a test to simulate a scenario where the user selectes a time slot in the past:
      - the user gets available time slots
      - user waits until a certian time slot passes
      - user press on passed time slot to create the meeting
      expected result is that user sees an error message and the page controls are cleared in order to get the new available time slots
    */
    testWidgets("test creating an event in the past in Cal's server", (WidgetTester tester) async {
      CalApi api = CalApi();
      DateTime start = DateTime.parse("2024-10-31T12:00:00.000Z");
      DateTime end = DateTime.parse("2024-10-31T12:15:00.000Z");
      expect(
        () async => await api.create("http", "10.0.2.2", 3000, "bet-hamikdash", "minha", 4, start, end, "Asia/Jerusalem", "aaa", "aaa@bbb.com"),
        throwsException);
    });

    testWidgets("test canceling an event in Cal's server", (WidgetTester tester) async {
      CalApi api = CalApi();
      DateTime start = DateTime.parse("2025-05-23T12:00:00.000Z");
      DateTime end = DateTime.parse("2025-05-23T12:15:00.000Z");
      var uid = await api.create("http", "10.0.2.2", 3000, "bet-hamikdash", "minha", 4, start, end, "Asia/Jerusalem", "aaa", "aaa@bbb.com");
      expect(uid, isNotNull);
      expect(uid, isNotEmpty);
      await expectLater(api.cancel("http", "10.0.2.2", 3000, uid), completes);
    });

//     testWidgets('tap on the floating action button, verify counter', (tester) async {
//       // Load app widget.
//       await tester.pumpWidget(const MyApp());

//       // Verify the counter starts at 0.
//       expect(find.text('0'), findsOneWidget);

//       // Finds the floating action button to tap on.
//       final fab = find.byKey(const ValueKey('increment'));

//       // Emulate a tap on the floating action button.
//       await tester.tap(fab);

//       // Trigger a frame.
//       await tester.pumpAndSettle();

//       // Verify the counter increments by 1.
//       expect(find.text('1'), findsOneWidget);
//     });
  });
}