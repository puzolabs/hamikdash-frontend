import 'package:flutter/services.dart' show rootBundle;

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
  }
}