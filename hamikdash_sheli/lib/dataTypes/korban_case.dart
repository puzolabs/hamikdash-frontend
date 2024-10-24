
import 'package:hamikdash_sheli/dataTypes/korban.dart';
import 'package:hamikdash_sheli/dataTypes/korbans_option.dart';

// 7 sections
enum Sections {
  none,
  happyEvent,
  nedarimUndavot,
  nazir, // in the middle since one event is happy and the other one is part khet part avon
  caparatHataim,
  caparatAvonot,
  mezora, // the overall context of mezora is bad and sad so its in the last but least since he was able to recover and become tahor
  sadEvent,
}

class KorbanCase
{
  Sections section;
  String title;
  List<Korban>? korbanot;
  List<KorbansOption>? korbanotOptions;

  KorbanCase({this.section = Sections.none, this.title = "", this.korbanot, this.korbanotOptions });

  bool get isSingleOptionKorbanCase => korbanot != null && korbanotOptions == null;
  bool get isMultiOptionsKorbanCase => korbanot == null && korbanotOptions != null;
  bool get isComplexKorbanCase => korbanot != null && korbanotOptions != null ;

  factory KorbanCase.fromJson(Map<String, dynamic> map) {
    String section = map["section"];
    String title = map["title"];
    var korbanot = map["korbanot"];
    var korbanotOptions = map["korbanotOptions"];

    List<Korban>? list = korbanot
      ?.map<Korban>((korban) => Korban.fromJson(korban))
      .toList();

    List<KorbansOption>? optionsList = korbanotOptions
      ?.map<KorbansOption>((option) => KorbansOption.fromJson(option))
      .toList();

    return KorbanCase(section: Sections.values.byName(section), title: title, korbanot: list, korbanotOptions: optionsList);
  }
}
