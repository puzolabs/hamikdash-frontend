
import 'package:hamikdash_sheli/dataTypes/korban_case.dart';
import 'package:hamikdash_sheli/dataTypes/korbans_option.dart';

class EventData {
  EventData({required this.eventTypeId, required this.eventName, required this.caseCode, required this.optionCode, required this.duration });

  int eventTypeId = 0;
  String eventName = "";
  CaseCodes caseCode = CaseCodes.none;
  OptionCodes optionCode = OptionCodes.none;
  Duration duration = const Duration();
}

List<EventData> eventMap = [
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.minhaNedava, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.minhaNeder, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.olaNedava, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.olaNeder, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.bitulAse, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.lavHanitakLeAse, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.hirhur, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.shogeg, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.shvuatSheker, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.shvuatShekerBeShogeg, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.tameLamikdash, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.tameKodashim, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.elilim, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.tameLamikdashBeShogeg, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.tameKodashimBeShogeg, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.ganav, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.loShilamti, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.shekerBePikadon, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.shekerBeMetzia, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.hekdesh, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.nazirTame, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.mezoraTahor, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.mesupak, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.nazir, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.shlamimNedava, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.shlamimNeder, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.bicurim, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.toda, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.todaNedava, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.todaNeder, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.bekhor, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.maaser, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.yoledet, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.mezoraTahorSofi, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.zav, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.ger, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.nesahimNedava, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
  EventData(eventTypeId: 4, eventName: "minha", caseCode: CaseCodes.nesahimNeder, optionCode: OptionCodes.none, duration: const Duration(minutes: 15)),
];
