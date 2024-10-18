import 'package:flutter/services.dart' show rootBundle;
import 'package:hamikdash_sheli/app_state.dart';

class CalLoader
{
  void loadAsset() async {
    var s = await rootBundle.loadString('lib/cal/inline_template.html');
    appState.calTemplate = s;
  }
}