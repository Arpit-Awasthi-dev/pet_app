import 'package:dartz/dartz.dart';
import 'package:pet_app/core/base_usecase/failures.dart';
import 'package:pet_app/domain/entities/pet.dart';

import '../usecases/get_pet_list_use_case.dart';

abstract class PetRepository {
  Future<Either<Failure, List<Pet>>> getPetList(GetPetListParams params);

  Future<Either<Failure, List<Pet>>> getAdoptedPetList();

  Future<Either<Failure, bool>> adoptPet(int id);

  Future<Either<Failure, bool>> cancelAdoption(int id);
}
