import 'package:flutter/foundation.dart';
import 'package:pet_app/core/db/tables/adopted_pets_table.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/models/local_models/local_pet_model.dart';

class DatabaseOperations {
  final Database database;

  DatabaseOperations({required this.database});

  /// -------------------- DB OPERATIONS -------------------

  Future<bool> storePetList(List<LocalPetModel> list) async {
    try {
      final batch = database.batch();
      for (final element in list) {
        batch.insert(
          PetTable().table,
          element.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
      await batch.commit(noResult: true);
      return Future.value(true);
    }catch(e){
      return Future.value(false);
    }
  }

  Future<List<LocalPetModel>> getPetList({
    required String query,
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await database.query(PetTable().table,
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
      final response = await database.query(
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
      final rowList = await database.query(
        PetTable().table,
        where: '${PetTable().columnID} LIKE ?',
        whereArgs: ['%$id%'],
      );
      if (rowList.isNotEmpty) {
        var row = LocalPetModel.fromJson(rowList[0]);
        row.adopted = adoptionStatus;

        await database.update(
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
}
