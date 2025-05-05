import 'package:keno_plus/features/authentication/domain/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  // Singleton pattern to ensure only one instance of the database is created
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initialize();
    return _database!;
  }

  static Future<Database> initialize() async {
    return openDatabase(
      join(await getDatabasesPath(), 'keno_plus.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(username TEXT PRIMARY KEY NOT NULL, firstName TEXT, lastName TEXT, birthdate TEXT, age INTEGER, phoneNumber TEXT, email TEXT, password TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertUser(Database db, User user) async {
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
