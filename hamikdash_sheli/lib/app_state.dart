
import 'package:hamikdash_sheli/dataTypes/user.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';

class AppState
{
  String calTemplate = "";
  User? user;
  Visit? currentVisit;
  List<Visit> visitList = <Visit>[];
  List<Visit> completedList = <Visit>[];
}

var appState = AppState();
