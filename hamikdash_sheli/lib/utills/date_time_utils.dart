import 'package:hamikdash_sheli/app_globals.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/timezone.dart' as tz;

//it is assumed the dt is in Jerusalem timezone
bool isTimePassedInJerusalem(DateTime dt) {
  TZDateTime timeInJerusalem = getCurrentTimeInJerusalem();
  return timeInJerusalem.isAfter(dt);
}

TZDateTime getCurrentTimeInJerusalem() {
  var timeInUtc = DateTime.now().toUtc();
  var timeInJerusalem = tz.TZDateTime.from(timeInUtc, app_globals.jerusalem!);

  print("time in utc is $timeInUtc and time in jerusalem is $timeInJerusalem");

  return timeInJerusalem;
}
