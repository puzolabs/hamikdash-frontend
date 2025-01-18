import 'package:hamikdash_sheli/calApi/cal_api.dart';
import 'package:hamikdash_sheli/dataTypes/korban_case.dart';
import 'package:hamikdash_sheli/dataTypes/korbans_option.dart';
import 'package:hamikdash_sheli/utills/list_enhancements.dart';
import 'package:jiffy/jiffy.dart';
import '../app_state.dart';
import '../dataTypes/event_data.dart';
import 'data_types/day_availability.dart';

class CalApiManager {
  final CalApi _api = CalApi();

  //find availability for the whole month, meaning start from the first day of the month,
  //since for most times the user would browse the calendar by entire months,
  //and only once, when the page loads, it would be optimized to start the search only from the day the page loaded - so it doesn't worth it.
  //when browsing next month - call getAvailbility() agin for that month
  Future<List<DayAvailability>> getMonthAvailability(CaseCodes caseCode, OptionCodes optionCode, DateTime time) async {
    var eventData =
      eventMap.findFirst((element) => element.caseCode == caseCode && element.optionCode == optionCode) ??
      eventMap.findFirst((element) => element.caseCode == caseCode);
    
    if(eventData == null) {
      return List.empty();
    }

    String eventName = eventData.eventName;

    var monthStartDate = _findMonthStartDate(time);
    var thisMonthStartDate = _findMonthStartDate(DateTime.now());

    if(monthStartDate.isBefore(thisMonthStartDate)) {   // past months has no availability
      print("user browsed to old month. returning empty list");
      return List.empty();
    }

    var monthEndDate = _findMonthEndDate(time);

    print("about to find availability between $monthStartDate and $monthEndDate");

    return await _api.getAvailability("http", "10.0.2.2", 3000, "bet-hamikdash", eventName, monthStartDate, monthEndDate, "Asia/Jerusalem");
  }
  
  DateTime _findMonthStartDate(DateTime start) {
    return Jiffy
      .parseFromDateTime(start)
      .startOf(Unit.month)
      .dateTime;
  }
  
  DateTime _findMonthEndDate(DateTime start) {
    return Jiffy
      .parseFromDateTime(start)
      .endOf(Unit.month)
      .dateTime;
  }

  Future create(CaseCodes caseCode, OptionCodes optionCode, DateTime start, {String? rescheduleUid}) async {
    var eventData =
      eventMap.findFirst((element) => element.caseCode == caseCode && element.optionCode == optionCode) ??
      eventMap.findFirst((element) => element.caseCode == caseCode);
    
    if(eventData == null) {
      return;
    }

    String eventName = eventData.eventName;
    int eventTypeId = eventData.eventTypeId;
    DateTime end = start.add(eventData.duration);
    
    String uid = await _api.create("http", "10.0.2.2", 3000, "bet-hamikdash", eventName, eventTypeId, start, end, "Asia/Jerusalem", appState.user!.name, appState.user!.email, rescheduleUid: rescheduleUid);
    appState.currentVisit!.uid = uid;
  }
}