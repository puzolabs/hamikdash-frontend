import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:hamikdash_sheli/calApi/data_types/day_availability.dart';

void main() {
  testWidgets('test builing the day availability', (WidgetTester tester) async {
    
    String json = """
    {
      "2024-10-02": [
        {
          "time": "2024-10-02T05:00:00.000Z"
        },
        {
          "time": "2024-10-02T05:30:00.000Z"
        },
        {
          "time": "2024-10-02T05:45:00.000Z"
        },
        {
          "time": "2024-10-02T08:00:00.000Z"
        },
        {
          "time": "2024-10-02T09:45:00.000Z"
        },
        {
          "time": "2024-10-02T12:30:00.000Z"
        },
        {
          "time": "2024-10-02T13:30:00.000Z"
        },
        {
          "time": "2024-10-02T13:45:00.000Z"
        }
      ]
    }
    """;

    var map = jsonDecode(json) as Map<String, dynamic>;

    DayAvailability dayAvailability = DayAvailability.fromJson(map);

    // Verify that our counter has incremented.
    expect(dayAvailability.timeSlots.length, 8);
  });
}
