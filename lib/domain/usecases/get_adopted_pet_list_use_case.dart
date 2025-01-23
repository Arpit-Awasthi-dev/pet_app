import 'package:dartz/dartz.dart';
import 'package:pet_app/core/base_usecase/failures.dart';
import 'package:pet_app/core/base_usecase/usecase.dart';
import 'package:pet_app/domain/repos/pet_repository.dart';

import '../entities/pet.dart';

class GetAdoptedPetListUseCase implements UseCase<List<Pet>, NoParams>{
  final PetRepository repository;

  GetAdoptedPetListUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Pet>>> call(NoParams params) async{
    return await repository.getAdoptedPetList();
  }

}