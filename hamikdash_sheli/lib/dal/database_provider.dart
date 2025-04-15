import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseProvider
{
  Database? _db;

  Future init(String dbName) async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, dbName);

    _db = await openDatabase(
      path,
      version: 2,
      // when creating the db on a new device
      onCreate: (Database db, int version) async {
        var batch = db.batch();
        _createVisitsTable(batch);
        _createCompletedVisitsTable(batch);
        await batch.commit();
      },
      // when upgrading the app version
      onUpgrade: (db, oldVersion, newVersion) async {
        var batch = db.batch();
        if (oldVersion == 1) {
          _createCompletedVisitsTable(batch);
        }
        await batch.commit();
      });
  }

  Database? get db => _db;

  void _createVisitsTable(Batch batch) {
    batch.execute(
      '''CREATE TABLE IF NOT EXISTS Visits (
          Id TEXT PRIMARY KEY NOT NULL,
          CaseCode INTEGER,
          OptionCode INTEGER,
          EventDateTime TEXT NOT NULL,
          CalId TEXT NOT NULL,
          DateCreated TEXT NOT NULL
         );'''
    );
  }

  void _createCompletedVisitsTable(Batch batch) {
    batch.execute(
      '''CREATE TABLE IF NOT EXISTS CompletedVisits (
          Id TEXT PRIMARY KEY NOT NULL,
          CaseCode INTEGER,
          OptionCode INTEGER,
          EventDateTime TEXT NOT NULL,
          CalId TEXT NOT NULL,
          DateCreated TEXT NOT NULL
         );'''
    );
  }

  Future close() async {
    await _db?.close();
  }
}