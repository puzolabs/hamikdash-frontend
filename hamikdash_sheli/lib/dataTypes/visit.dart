
import 'package:hamikdash_sheli/dataTypes/korban_case.dart';
import 'package:hamikdash_sheli/dataTypes/korbans_option.dart';

enum ComingOption
{
  prepareAllForMe,
  bringingAllWithMe,
}

enum Status
{
  pending,
  inProgress,
  done
}

class Visit
{
  int id = 0;
  CaseCodes caseCode = CaseCodes.none;
  OptionCodes optionCode = OptionCodes.none;
  ComingOption comingOption = ComingOption.prepareAllForMe;
  DateTime? dateTime;
  int? paymentAmount;
  Status status = Status.pending;
  String uid = "";

  Visit();

  Visit.withData(this.id, this.caseCode, this.optionCode, this.dateTime, this.uid);

  factory Visit.fromDatabase(Map<String, dynamic> map) {
    int id = map["Id"];
    int caseCode = map["CaseCode"];
    int optionCode = map["OptionCode"];
    String dateTime = map["EventDateTime"];
    String uid = map["CalId"];

    return Visit.withData(id, CaseCodes.values[caseCode], OptionCodes.values[optionCode], DateTime.parse(dateTime), uid);
  }
}
