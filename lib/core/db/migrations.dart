import 'package:sqflite/sqflite.dart';

class Migrations {
  static Future<void> run(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Ejemplo futuro:
      // await db.execute("ALTER TABLE shopping_lists ADD COLUMN color TEXT;");
    }

    if (oldVersion < 3) {
      // Otra futura migración
    }
  }
}
