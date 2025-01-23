import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_app/core/shared_preference.dart';
import 'package:pet_app/data/models/local_models/local_pet_model.dart';
import 'package:sqflite/sqflite.dart';

import 'tables/adopted_pets_table.dart';

class DatabaseHelper {
  static const _databaseName = 'pet_app_db';
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    // Get the documents directory.
    final documentsDirectory = await getApplicationDocumentsDirectory();
    // Construct the path to the database file.
    final databasePath = join(documentsDirectory.path, _databaseName);
    // Open/create the database at the constructed path.
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

  /// -------------------- DB OPERATIONS -------------------

  Future<void> storePetList() async {
    final Database db = await instance.database;
    final batch = db.batch();
    List<LocalPetModel> list = _preFilledList;
    for (final element in list) {
      batch.insert(
        PetTable().table,
        element.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await batch.commit(noResult: true);
    SharedAccess().storeBool(PreferenceKeys.listStored, true);
  }

  Future<List<LocalPetModel>> getPetList({
    required String query,
    required int limit,
    required int offset,
  }) async {
    try {
      final Database db = await instance.database;
      final response = await db.query(PetTable().table,
          where: '${PetTable().columnName} LIKE ?',
          whereArgs: ['%$query%'],
          limit: limit,
          offset: offset);

      final List<LocalPetModel> petList = response.isNotEmpty
          ? response.map((e) => LocalPetModel.fromJson(e)).toList()
          : [];

      return petList;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception();
    }
  }

  Future<List<LocalPetModel>> getAdoptedPetList() async {
    try {
      final Database db = await instance.database;
      final response = await db.query(
        PetTable().table,
        where: '${PetTable().columnAdopted} LIKE ?',
        whereArgs: ['%1%'],
      );

      final List<LocalPetModel> petList = response.isNotEmpty
          ? response.map((e) => LocalPetModel.fromJson(e)).toList()
          : [];

      return petList;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception();
    }
  }

  Future<bool> changeAdoptionStatus(int id, bool adoptionStatus) async {
    try {
      final Database db = await instance.database;
      final rowList = await db.query(
        PetTable().table,
        where: '${PetTable().columnID} LIKE ?',
        whereArgs: ['%$id%'],
      );
      if (rowList.isNotEmpty) {
        var row = LocalPetModel.fromJson(rowList[0]);
        row.adopted = adoptionStatus;

        await db.update(
          PetTable().table,
          row.toJson(),
          where: '${PetTable().columnID} = ?',
          whereArgs: [id],
        );
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      throw Exception();
    }
  }

  //
  // Future<String?> getWikiDetail(int pageID) async {
  //   final Database db = await instance.database;
  //   final rowList = await db.query(
  //     WikiTable().table,
  //     where: '${WikiTable().columnPageID} LIKE ?',
  //     whereArgs: ['%$pageID%'],
  //   );
  //
  //   if (rowList.isNotEmpty) {
  //     final wikiItem = LocalWikiItem.fromJson(rowList[0]);
  //     return wikiItem.detail;
  //   }
  //   return null;
  // }

  final List<LocalPetModel> _preFilledList = [
    LocalPetModel(
      category: 'horse',
      name: 'Grade Horse',
      age: '10',
      price: '150000',
      image: 'assets/grade_horse.jpg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'bird',
      name: 'Cockatiel',
      age: '3',
      price: '7000',
      image: 'assets/cockatiel.jpg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'horse',
      name: 'American Quater Horse',
      age: '7',
      price: '170000',
      image: 'assets/american_quarter.jpg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'cow',
      name: 'Holstein – The Classics',
      age: '6',
      price: '50000',
      image: 'assets/holstein.jpg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'dog',
      name: 'indie',
      age: '3',
      price: '5000',
      image: 'assets/indie.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'cat',
      name: 'Bengal Cat',
      age: '2',
      price: '10000',
      image: 'assets/bengal_cat.jpg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'horse',
      name: 'Arabian',
      age: '7',
      price: '700000',
      image: 'assets/arabian.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'cow',
      name: 'Jersey',
      age: '5',
      price: '40000',
      image: 'assets/jersey.jpg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'dog',
      name: 'Great Dane',
      age: '3',
      price: '40000',
      image: 'assets/great_dane.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'cat',
      name: 'Abyssinian',
      age: '3',
      price: '15000',
      image: 'assets/abyssinian_cat.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'bird',
      name: 'dove',
      age: '1',
      price: '3000',
      image: 'assets/dove.jpeg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'cat',
      name: 'Persian',
      age: '1',
      price: '20000',
      image: 'assets/persian_cat.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'horse',
      name: 'Thorough Bred',
      age: '4',
      price: '200000',
      image: 'assets/thoroughbred.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'cow',
      name: 'Brown Swiss',
      age: '5',
      price: '120000',
      image: 'assets/brownswiss.jpg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'horse',
      name: 'American Quater Horse',
      age: '7',
      price: '170000',
      image: 'assets/american_quarter.jpg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'bird',
      name: 'African Grey Parrot',
      age: '7',
      price: '170000',
      image: 'assets/african_grey_parrot.jpeg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'bird',
      name: 'Canary',
      age: '1',
      price: '6000',
      image: 'assets/canary.jpeg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'horse',
      name: 'Appaloosa',
      age: '3',
      price: '150000',
      image: 'assets/appaloosa.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'cow',
      name: 'Guernsey',
      age: '4',
      price: '80000',
      image: 'assets/guernsey.jpg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'dog',
      name: 'Doberman',
      age: '2',
      price: '35000',
      image: 'assets/doberman.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'dog',
      name: 'Golden Retriever',
      age: '2',
      price: '170000',
      image: 'assets/golden_retriever.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'horse',
      name: 'Pony',
      age: '2',
      price: '60000',
      image: 'assets/ponies.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'bird',
      name: 'Pionus Parrot',
      age: '1',
      price: '3500',
      image: 'assets/pionus_parrot.jpeg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'horse',
      name: 'Warmblood',
      age: '2',
      price: '600000',
      image: 'assets/warmbloods.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'dog',
      name: 'Tibetan Mastiff',
      age: '2',
      price: '150000',
      image: 'assets/tibetan_mastiff.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'dog',
      name: 'Shih Tzus',
      age: '2',
      price: '60000',
      image: 'assets/shih_tzus.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'horse',
      name: 'Morgan',
      age: '2',
      price: '300000',
      image: 'assets/morgan.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'dog',
      name: 'Rottweiler',
      age: '4',
      price: '30000',
      image: 'assets/rottweiler.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'bird',
      name: 'Hyacinth Macaw',
      age: '2',
      price: '15000',
      image: 'assets/hyacinth_macaw.jpeg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'dog',
      name: 'Cocker Spaniel',
      age: '1',
      price: '25000',
      image: 'assets/cocker_spaniel.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'dog',
      name: 'Pug',
      age: '3',
      price: '15000',
      image: 'assets/pug.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'dog',
      name: 'Boxer',
      age: '2',
      price: '17000',
      image: 'assets/boxer.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'dog',
      name: 'Pomeranian',
      age: '2',
      price: '7500',
      image: 'assets/pomeranian.webp',
      adopted: false,
    ),
    LocalPetModel(
      category: 'cow',
      name: 'Ayrshire',
      age: '4',
      price: '40000',
      image: 'assets/ayrshire.jpg',
      adopted: false,
    ),
    LocalPetModel(
      category: 'cat',
      name: 'Oriental Shorthair',
      age: '2',
      price: '15000',
      image: 'assets/oriental_shorthair_cat.webp',
      adopted: false,
    ),
  ];
}
