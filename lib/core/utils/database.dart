import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Future<Database> initialize() async {
    return openDatabase(
      join(await getDatabasesPath(), 'keno_plus.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE users(
            username TEXT PRIMARY KEY,
            name TEXT,
            email TEXT,
            password TEXT,
            phone TEXT,
            birthdate TEXT,
            age INTEGER,
          )
          ''');
      },
      version: 1,
    );
  }
}
