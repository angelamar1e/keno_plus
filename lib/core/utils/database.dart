import 'package:keno_plus/core/values/app_imports.dart';
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
      onCreate: (db, version) async {
        // Create users table
        await db.execute(
          'CREATE TABLE users(username TEXT PRIMARY KEY NOT NULL, firstName TEXT, lastName TEXT, birthdate TEXT, age INTEGER, phoneNumber TEXT, email TEXT, password TEXT)',
        );

        // Create game_history table
        await db.execute('''
          CREATE TABLE game_history(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT NOT NULL,
            game_mode TEXT NOT NULL,
            wager REAL NOT NULL,
            card_payouts TEXT NOT NULL
          )
        ''');
      },
      version: 1,
    );
  }
}
