import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'tables.dart';
import 'migrations.dart';

class SQLiteDatabase {
  static final SQLiteDatabase _instance = SQLiteDatabase._internal();
  factory SQLiteDatabase() => _instance;

  SQLiteDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'shopping_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(Tables.createShoppingLists);
    await db.execute(Tables.createShoppingItems);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await Migrations.run(db, oldVersion, newVersion);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
