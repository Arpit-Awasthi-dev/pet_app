import 'package:dartz/dartz.dart';
import 'package:pet_app/core/base_usecase/failures.dart';
import 'package:pet_app/domain/entities/pet.dart';
import 'package:pet_app/domain/repos/pet_repository.dart';
import 'package:pet_app/domain/usecases/get_pet_list_use_case.dart';

import '../data_sources/pet_local_data_source.dart';

class PetRepoImpl implements PetRepository {
  final PetLocalDataSource _localDataSource;

  PetRepoImpl({required PetLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<Either<Failure, List<Pet>>> getPetList(GetPetListParams params) async {
    try {
      var response = await _localDataSource.getPetList(params);
      var petList = response
          .map((localPet) => Pet(
                id: localPet.id,
                category: localPet.category,
                name: localPet.name,
                age: localPet.age,
                price: localPet.price,
                image: localPet.image,
                isAdopted: localPet.adopted,
              ))
          .toList();
      return Right(petList);
    } catch (e) {
      return Future.value(Left(Failure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<Pet>>> getAdoptedPetList() async {
    try {
      var response = await _localDataSource.getAdoptedPetList();
      var petList = response
          .map((localPet) => Pet(
        id: localPet.id,
        category: localPet.category,
        name: localPet.name,
        age: localPet.age,
        price: localPet.price,
        image: localPet.image,
        isAdopted: localPet.adopted,
      ))
          .toList();
      return Right(petList);
    } catch (e) {
      return Future.value(Left(Failure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> adoptPet(int id) async{
    try {
      var response = await _localDataSource.adoptPet(id);
      return Right(response);
    } catch (e) {
      return Future.value(Left(Failure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelAdoption(int id) async{
    try {
      var response = await _localDataSource.adoptPet(id);
      return Right(response);
    } catch (e) {
      return Future.value(Left(Failure(message: e.toString())));
    }
  }
}
