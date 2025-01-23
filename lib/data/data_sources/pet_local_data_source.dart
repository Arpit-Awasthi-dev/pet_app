import 'package:pet_app/core/db/database_service.dart';
import 'package:pet_app/data/models/local_models/local_pet_model.dart';

import '../../core/db/database_operations.dart';
import '../../domain/usecases/get_pet_list_use_case.dart';

abstract class PetLocalDataSource {
  Future<List<LocalPetModel>> getPetList(GetPetListParams params);

  Future<bool> adoptPet(int id);

  Future<bool> cancelAdoption(int id);

  Future<List<LocalPetModel>> getAdoptedPetList();
}

class PetLocalDataSourceImpl implements PetLocalDataSource {
  final DatabaseService service;

  PetLocalDataSourceImpl({required this.service});

  @override
  Future<List<LocalPetModel>> getPetList(GetPetListParams params) async {
    await Future.delayed(const Duration(seconds: 2));
    final response =
        await DatabaseOperations(database: await service.database).getPetList(
      query: params.query,
      limit: params.limit,
      offset: params.offset,
    );

    return response;
  }

  @override
  Future<bool> adoptPet(int id) async {
    final response = await DatabaseOperations(database: await service.database)
        .changeAdoptionStatus(id, true);
    return response;
  }

  @override
  Future<bool> cancelAdoption(int id) async {
    final response = await DatabaseOperations(database: await service.database)
        .changeAdoptionStatus(id, false);
    return response;
  }

  @override
  Future<List<LocalPetModel>> getAdoptedPetList() async {
    final response = await DatabaseOperations(database: await service.database)
        .getAdoptedPetList();

    return response;
  }
}
