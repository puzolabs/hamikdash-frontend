import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class calApi {
  Future getAvailability(String scheme, String host, int port, String teamName, String eventName, DateTime dtStart, String end, String timeZone) async {
    String start = DateFormat('yyyy-MM-ddTHH:mm:ss.000Z').format(dtStart);
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
      response = await http.get(uri);
    } on ClientException catch (error) {
      print(error.toString());
      throw Exception('Failed to get availability time slots');
    }

    if (response.statusCode == 200) {
      print(response.body);
        //return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      print(response.request!.url.query);
      throw Exception('Failed to get availability time slots');
    }
  }

  Future create() async {

  }

  Future reschedule() async {

  }

  Future cancel() async {

  }
}