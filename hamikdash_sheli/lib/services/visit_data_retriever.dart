
import 'package:hamikdash_sheli/app_config.dart';
import 'package:hamikdash_sheli/dataTypes/korban.dart';
import 'package:hamikdash_sheli/dataTypes/korban_case.dart';
import 'package:hamikdash_sheli/dataTypes/korbans_option.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';
import 'package:hamikdash_sheli/utills/list_enhancements.dart';

class VisitDataRetriever {
  Visit visit;
  KorbanCase? korbanCase;
  KorbansOption? korbansOption;

  VisitDataRetriever({required this.visit}) {
    korbanCase = appConfig.korbanCases.findFirst((kc) => kc.code == visit.caseCode);
    
    if(korbanCase?.korbanotOptions != null && visit.optionCode != OptionCodes.none) {
      korbansOption = korbanCase!.korbanotOptions!.findFirst((ko) => ko.code == visit.optionCode);
    }
  }

  String getTitle() {
    if(korbanCase == null) {
      return "";
    }

    return korbanCase!.title;
  }

  String getImage() {
    if(korbanCase == null) {
      return "";
    }

    return korbanCase!.image;
  }

  List<Korban>? getKorbans() {
    if(korbanCase == null) {
      return null;
    }
    
    return
      korbanCase!.isSingleOptionKorbanCase
      ? korbanCase!.korbanot
      : korbanCase!.isMultiOptionsKorbanCase
        ? korbansOption!.korbans
        : korbanCase!.isComplexKorbanCase
          ? _combineKorbans()
          : null;
  }

  List<Korban>? _combineKorbans() {
    return List<Korban>
      .from(korbanCase!.korbanot as Iterable)
      ..addAll(korbansOption!.korbans);
  }
}