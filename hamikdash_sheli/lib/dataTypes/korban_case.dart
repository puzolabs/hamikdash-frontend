
import 'package:hamikdash_sheli/dataTypes/korban.dart';
import 'package:hamikdash_sheli/dataTypes/korbans_option.dart';

class KorbanCase
{
  String title;
  List<Korban>? korbanot;
  List<KorbansOption>? korbanotOptions;

  KorbanCase({this.title = "", this.korbanot, this.korbanotOptions });

  bool get isSingleOptionKorbanCase => korbanot != null && korbanotOptions == null;
  bool get isMultiOptionsKorbanCase => korbanot == null && korbanotOptions != null;
  bool get isComplexKorbanCase => korbanot != null && korbanotOptions != null ;

  factory KorbanCase.fromJson(Map<String, dynamic> map) {
    String title = map["title"];
    var korbanot = map["korbanot"];
    var korbanotOptions = map["korbanotOptions"];

    List<Korban> list = korbanot
      .map<Korban>((korban) => Korban.fromJson(korban))
      .toList();

    List<KorbansOption> optionsList = korbanotOptions
      .map<KorbansOption>((option) => KorbansOption.fromJson(option))
      .toList();

    return KorbanCase(title: title, korbanot: list, korbanotOptions: optionsList);
  }
}
