
import 'package:hamikdash_sheli/dataTypes/korban.dart';

class KorbansOption
{
  String name;
  List<Korban> korbans;

  KorbansOption({required this.name, required this.korbans});

  factory KorbansOption.fromJson(Map<String, dynamic> map) {
    String title = map["title"];
    var korbanot = map["korbanot"];

    List<Korban> list = korbanot
      .map<Korban>((korban) => Korban.fromJson(korban))
      .toList();
    
    return KorbansOption(name: title, korbans: list);
  }
}