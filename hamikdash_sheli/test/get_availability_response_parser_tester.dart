import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:hamikdash_sheli/calApi/data_types/get_availability_response_parser.dart';

void main() {
  testWidgets('test builing the day availability', (WidgetTester tester) async {
    
    String json = """
    {
      "result": {
        "data": {
          "json": {
            "slots": {
              "2024-10-02": [
                {
                  "time": "2024-10-02T05:00:00.000Z"
                },
                {
                  "time": "2024-10-02T13:45:00.000Z"
                }
              ],
              "2024-10-03": [
                {
                  "time": "2024-10-03T07:45:00.000Z"
                },
                {
                  "time": "2024-10-03T11:15:00.000Z"
                }
              ],
              "2024-10-04": [
                {
                  "time": "2024-10-04T08:30:00.000Z"
                },
                {
                  "time": "2024-10-04T09:45:00.000Z"
                }
              ]
            }
          }
        }
      }
    }
    """;

    var map = jsonDecode(json) as Map<String, dynamic>;

    GetAvailabilityResponseParser parser = GetAvailabilityResponseParser.fromJson(map);

    expect(parser.daysAvailability.length, 3);
  });
}
