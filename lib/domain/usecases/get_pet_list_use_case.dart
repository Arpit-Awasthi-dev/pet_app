import 'package:dartz/dartz.dart';
import 'package:pet_app/core/base_usecase/failures.dart';
import 'package:pet_app/core/base_usecase/usecase.dart';
import 'package:pet_app/domain/entities/pet.dart';
import 'package:pet_app/domain/repos/pet_repository.dart';

class GetPetListUseCase implements UseCase<List<Pet>, GetPetListParams> {
  final PetRepository repository;

  GetPetListUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Pet>>> call(GetPetListParams params) async {
    return await repository.getPetList(params);
  }
}

class GetPetListParams {
  final String query;
  final int limit = 12;
  final int offset;

  GetPetListParams({
    required this.query,
    required int pageNo,
  }) : offset = pageNo * 12;
}
