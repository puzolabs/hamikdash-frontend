
import 'package:hamikdash_sheli/dal/database_provider.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class VisitsRepository {
  Database? _database;
  
  VisitsRepository(DatabaseProvider databaseProvider) {
    _database = databaseProvider.db;
  }

  Future insert(Visit visit) async {
    String sql = '''
      insert into Visits
      (
        CaseCode,
        OptionCode,
        EventDateTime,
        CalId,
        DateCreated
      )
      values (?, ?, ?, ?, ?)
    ''';

    String eventDate = DateFormat('yyyy-MM-dd HH:mm').format(visit.dateTime!);
    String currentDate = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now().toUtc());

    visit.id = await _database!.rawInsert(sql, [
      visit.caseCode.index,
      visit.optionCode.index,
      eventDate,
      visit.uid,
      currentDate]);
  }

  Future<Visit> get(int visitId) async {
    String sql = '''
      select *
      from Visits v
      where v.Id = ?
    ''';

    var list = await _database!.rawQuery(sql, [visitId]);
    return Visit.fromDatabase(list.first);
  }
}