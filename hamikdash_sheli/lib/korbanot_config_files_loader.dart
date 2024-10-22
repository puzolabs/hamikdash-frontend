import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:hamikdash_sheli/app_config.dart';
import 'package:hamikdash_sheli/dataTypes/korban_case.dart';

class KorbanotConfigFilesLoader
{
  void load() async {
    var front = await rootBundle.loadString('lib/assets/korbanot/front.json');
    var ger = await rootBundle.loadString('lib/assets/korbanot/ger.json');
    var mezora = await rootBundle.loadString('lib/assets/korbanot/mezora.json');
    var minha = await rootBundle.loadString('lib/assets/korbanot/minha.json');
    var nesahim = await rootBundle.loadString('lib/assets/korbanot/nesahim.json');
    var ola = await rootBundle.loadString('lib/assets/korbanot/ola.json');
    var oleVeyored = await rootBundle.loadString('lib/assets/korbanot/ole_veyored.json');
    var shlamimToda = await rootBundle.loadString('lib/assets/korbanot/shlamim_toda.json');
    var shlamim = await rootBundle.loadString('lib/assets/korbanot/shlamim.json');
    var toda = await rootBundle.loadString('lib/assets/korbanot/toda.json');
    var yoledet = await rootBundle.loadString('lib/assets/korbanot/yoledet.json');

    var cases = front
      .replaceAll("korbanotReference", "korbanot")
      .replaceAll("\"ger.json\"", ger)
      .replaceAll("\"mezora.json\"", mezora)
      .replaceAll("\"minha.json\"", minha)
      .replaceAll("\"nesahim.json\"", nesahim)
      .replaceAll("\"ola.json\"", ola)
      .replaceAll("\"ole_veyored.json\"", oleVeyored)
      .replaceAll("\"shlamim_toda.json\"", shlamimToda)
      .replaceAll("\"shlamim.json\"", shlamim)
      .replaceAll("\"toda.json\"", toda)
      .replaceAll("\"yoledet.json\"", yoledet);
  
    var array = jsonDecode(cases);

    List<KorbanCase> list = array
      .map<KorbanCase>((kc) => KorbanCase.fromJson(kc))
      .toList();

    appConfig.korbanCases = list;
  }
}