
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
  CaseCodes caseCode = CaseCodes.none;
  OptionCodes optionCode = OptionCodes.none;
  ComingOption comingOption = ComingOption.prepareAllForMe;
  DateTime? dateTime;
  int? paymentAmount;
  Status status = Status.pending;
  String uid = "";
}
