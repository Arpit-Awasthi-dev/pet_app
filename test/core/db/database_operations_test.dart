import 'package:flutter_test/flutter_test.dart';
import 'package:pet_app/core/db/database_operations.dart';
import 'package:pet_app/core/db/tables/adopted_pets_table.dart';
import 'package:pet_app/core/prior_data.dart';
import 'package:pet_app/data/models/local_models/local_pet_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Database database;
  late DatabaseOperations databaseOperations;

  group('Db operations test', () {
    setUpAll(() async {
      database = await databaseFactoryFfi.openDatabase(
        inMemoryDatabasePath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (Database db, int version) async {
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
          },
        ),
      );

      databaseOperations = DatabaseOperations(database: database);
    });

    test('first list of pet should be inserted', () async {
      /// Arrange
      List<LocalPetModel> list = PriorData().preFilledList;

      /// Act
      bool success = await databaseOperations.storePetList(list);

      ///  Assert
      expect(success, true);
    });

    test('Adopted value should change', () async {
      await databaseOperations.changeAdoptionStatus(1, true);

      List<LocalPetModel> list =
      await databaseOperations.getPetList(query: '', limit: 2, offset: 0);

      expect(list[0].adopted, true);
    });

    test('get only adopted pets', () async {
      await databaseOperations.changeAdoptionStatus(1, true);
      await databaseOperations.changeAdoptionStatus(2, true);
      await databaseOperations.changeAdoptionStatus(3, true);

      List<LocalPetModel> list =
      await databaseOperations.getAdoptedPetList();

      bool isAdopted = true;
      for (int i = 0; i<list.length; i++){
        if(!list[i].adopted){
          isAdopted = false;
          break;
        }
      }

        expect(isAdopted, true);
    });

    tearDownAll(() {
      database.close();
    });
  });
}
