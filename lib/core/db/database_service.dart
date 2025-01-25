import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'tables/adopted_pets_table.dart';

class DatabaseService {
  static const _databaseName = 'pet_app_db';
  static const _databaseVersion = 1;

  DatabaseService._privateConstructor();

  static final DatabaseService instance = DatabaseService._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    final String databasePath;
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      databasePath = 'my_web_web.db';
    }else{
      // Get the documents directory.
      final documentsDirectory = await getApplicationDocumentsDirectory();
      // Construct the path to the database file.
      databasePath = join(documentsDirectory.path, _databaseName);
    }
    return openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onCreate(Database db, int version) async {
    await _createWikiListTable(db);
    // await _storePetList(_preFilledList);
  }

  Future<void> _createWikiListTable(Database db) async {
    await db.execute('''
    CREATE TABLE ${PetTable().table} (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${PetTable().columnCategory} TEXT NOT NULL,
      ${PetTable().columnName} TEXT NOT NULL,
      ${PetTable().columnAge} TEXT NOT NULL,
      ${PetTable().columnPrice} TEXT NOT NULL,
      ${PetTable().columnImage} TEXT NOT NULL,
      ${PetTable().columnAdopted} BOOLEAN
    )
  ''');
  }

  /// wont be functional here
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    final Map<int, Function(Database)> migrationFunctions = {};

    if (newVersion <= oldVersion) {
      return;
    }

    for (int i = oldVersion + 1; i <= newVersion; i++) {
      final migrationFunction = migrationFunctions[i];
      if (migrationFunction == null) {
        throw Exception('Error: Migration function for version $i not found.');
      }
      migrationFunction(db);
    }
  }
}
