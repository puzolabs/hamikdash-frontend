import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseProvider
{
  Database? _db;

  Future init() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'bet-hamikdash.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String columns = _getTableColumnsDefinition();

        // When creating the db, create the table
        await db.execute(
        '''CREATE TABLE IF NOT EXISTS Visits (
            $columns
          );

          CREATE TABLE IF NOT EXISTS CompletedVisits (
            $columns
          );
        ''');
    });
  }

  Database? get db => _db;

  String _getTableColumnsDefinition() {
    return 
      '''
        Id TEXT PRIMARY KEY,
        CaseCode INTEGER,
        OptionCode INTEGER,
        EventDateTime TEXT NOT NULL,
        CalId TEXT NOT NULL,
        DateCreated TEXT NOT NULL
      ''';
  }

  Future close() async {
    await _db?.close();
  }
}