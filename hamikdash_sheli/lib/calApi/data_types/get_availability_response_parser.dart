
import 'package:hamikdash_sheli/calApi/data_types/day_availability.dart';

class GetAvailabilityResponseParser {
  final List<DayAvailability> daysAvailability;

  GetAvailabilityResponseParser({required this.daysAvailability});

  factory GetAvailabilityResponseParser.fromJson(Map<String, dynamic> map) {
    var slots = map["result"]["data"]["json"]["slots"] as Map<String, dynamic>;

    var list = slots.entries.map((s) {
      Map<String, dynamic> input = {
        s.key: s.value
      };
      return DayAvailability.fromJson(input);
    })
    .toList();

    return GetAvailabilityResponseParser(daysAvailability: list);
  }
}