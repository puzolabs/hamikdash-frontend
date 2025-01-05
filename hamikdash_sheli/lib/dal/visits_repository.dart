
import 'package:hamikdash_sheli/dal/database_provider.dart';
import 'package:hamikdash_sheli/dataTypes/visit.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class VisitsRepository {
  Database? _database;
  String? tableName;
  
  VisitsRepository(DatabaseProvider databaseProvider, this.tableName) {
    _database = databaseProvider.db;
  }

  Future insert(Visit visit) async {
    String sql = '''
      insert into $tableName
      (
        Id,
        CaseCode,
        OptionCode,
        EventDateTime,
        CalId,
        DateCreated
      )
      values (?, ?, ?, ?, ?, ?)
    ''';

    String eventDate = DateFormat('yyyy-MM-dd HH:mm').format(visit.dateTime!);
    String currentDate = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now().toUtc());

    await _database!.rawInsert(sql, [
      visit.id,
      visit.caseCode.index,
      visit.optionCode.index,
      eventDate,
      visit.uid,
      currentDate]);
  }

  Future<Visit> get(String visitId) async {
    String sql = '''
      select *
      from $tableName v
      where v.Id = ?
    ''';

    var list = await _database!.rawQuery(sql, [visitId]);
    return Visit.fromDatabase(list.first);
  }

  Future<List<Visit>> getAll() async {
    var list = await _database!.query(tableName!);

    List<Visit> returnList = list
      .map((visit) => Visit.fromDatabase(visit))
      .toList();

      return returnList;
  }

  Future<bool> delete(String visitId) async {
    var affectedRows = await _database!.delete(tableName!, where: 'Id = ?', whereArgs: [visitId]);
    return affectedRows == 1;
  }
}