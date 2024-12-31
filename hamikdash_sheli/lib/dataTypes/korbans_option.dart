
import 'package:hamikdash_sheli/dataTypes/korban.dart';

enum OptionCodes {
  none,
  firstOption,
  secondOption,
  thirdOption,
  forthOption,
  fifthOption
}

class KorbansOption
{
  OptionCodes code;
  String name;
  List<Korban> korbans;

  KorbansOption({required this.code, required this.name, required this.korbans});

  factory KorbansOption.fromJson(Map<String, dynamic> map) {
    String code = map["code"];
    String title = map["title"];
    var korbanot = map["korbanot"];

    List<Korban> list = korbanot
      .map<Korban>((korban) => Korban.fromJson(korban))
      .toList();
    
    return KorbansOption(code: OptionCodes.values.byName(code), name: title, korbans: list);
  }
}