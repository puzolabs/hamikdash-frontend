import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'data_types/day_availability.dart';
import 'data_types/get_availability_response_parser.dart';

class CalApi {
  Future<List<DayAvailability>> getAvailability(String scheme, String host, int port, String teamName, String eventName, DateTime dtStart, DateTime dtEnd, String timeZone) async {
    String start = DateFormat('yyyy-MM-ddTHH:mm:ss.000Z').format(dtStart);
    String end   = DateFormat('yyyy-MM-ddTHH:mm:ss.000Z').format(dtEnd);
    //String start = "2024-08-31T21:00:00.000Z"; // "2024-09-30T21:00:00.000Z";
    //String end = "2024-09-30T20:59:59.999Z"; // "2024-10-31T21:59:59.999Z";

    String getAvailabilityTemplate = 
    """{
      "json": {
        "isTeamEvent": true,
        "usernameList": [
          "{{teamName}}"
        ],
        "eventTypeSlug": "{{eventName}}",
        "startTime": "{{start}}",
        "endTime": "{{end}}",
        "timeZone": "{{timeZone}}",
        "duration": null,
        "rescheduleUid": null
      },
      "meta": {
        "values": {
          "duration": [
            "undefined"
          ]
        }
      }
    }""";

    String payload = getAvailabilityTemplate
    .replaceAll(" ", "")
    .replaceAll("\n", "")
    .replaceFirst("{{teamName}}", teamName)
    .replaceFirst("{{eventName}}", eventName)
    .replaceFirst("{{start}}", start)
    .replaceFirst("{{end}}", end)
    .replaceFirst("{{timeZone}}", timeZone);

    Uri uri = Uri(
      scheme: scheme,
      host: host,
      port: port,
      path: '/api/trpc/public/slots.getSchedule',
      queryParameters: {'input': payload}); // this will url-encode the payload!

    final Response response;
    try {
      response = await http.get(uri, headers:
        {
          "Connection": "keep-alive",
          "Keep-Alive": "timeout=5, max=1000",
          "Content-Type": "application/json",
          'Accept-Encoding': 'gzip, deflate, br'
        });
    } on ClientException catch (error) {
      print(error.toString());
      throw Exception('Failed to get availability time slots');
    }

    if (response.statusCode == 200) {
      print(response.body);
      var map = jsonDecode(response.body) as Map<String, dynamic>;
      GetAvailabilityResponseParser parser = GetAvailabilityResponseParser.fromJson(map);
      return parser.daysAvailability;
    } else {
      print(response.request!.url.query);
      throw Exception('Failed to get availability time slots');
    }
  }

  Future<String> create(String scheme, String host, int port, String teamName, String eventName, int eventTypeId, DateTime dtStart, DateTime dtEnd, String timeZone, String userName, String userEmail, {String? rescheduleUid}) async {
    String start = DateFormat('yyyy-MM-ddTHH:mm:ss.000Z').format(dtStart);
    String end   = DateFormat('yyyy-MM-ddTHH:mm:ss.000Z').format(dtEnd);

    String template = 
    """{
      "responses": {
        "email": "{{userEmail}}",
        "name": "{{userName}}",
        "guests": [],
        "location": {
          "optionValue": "",
          "value": "In Person (Organizer Address)"
        }
      },
      "user": "{{teamName}}",
      "start": "{{start}}",
      "end": "{{end}}",
      "eventTypeId": {{eventTypeId}},
      "eventTypeSlug": "{{eventName}}",
      "timeZone": "{{timeZone}}",
      "language": "en",
      "metadata": {},
      {{rescheduleSection}}
      "hasHashedBookingLink": false
    }""";

    String payload = template
    .replaceAll(" ", "")
    .replaceAll("\n", "")
    .replaceFirst("{{teamName}}", teamName)
    .replaceFirst("{{eventName}}", eventName)
    .replaceFirst("{{eventTypeId}}", eventTypeId.toString())
    .replaceFirst("{{start}}", start)
    .replaceFirst("{{end}}", end)
    .replaceFirst("{{timeZone}}", timeZone)
    .replaceFirst("{{userEmail}}", userEmail)
    .replaceFirst("{{userName}}", userName)
    .replaceFirst("{{rescheduleSection}}", rescheduleUid == null ? "" : _buildRescheduleSection(rescheduleUid));

    Uri uri = Uri(
      scheme: scheme,
      host: host,
      port: port,
      path: '/api/book/event');

    final Response response;
    try {
      response = await http.post(uri, headers:
        {
          "Content-Type": "application/json",
        },
        body: payload);
    } on ClientException catch (error) {
      print(error.toString());
      throw Exception('Failed to create a meeting');
    }

    if (response.statusCode == 200) {
      print(response.body);
      var map = jsonDecode(response.body) as Map<String, dynamic>;
      String uid = map["uid"];
      return uid;
    } else if (response.statusCode == 500 && response.body.contains("No available users found")) { // Internal Server Error
      throw Exception('Time slot is taken');
    } else {
      throw Exception('Failed to create a meeting');
    }
  }

  String _buildRescheduleSection(String uid) {
    String section = """
      "rescheduleUid": "$uid",
      "bookingUid": "$uid",
    """;

    return section;
  }

  Future cancel() async {

  }
}