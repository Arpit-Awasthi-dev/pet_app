import 'package:dartz/dartz.dart';
import 'package:pet_app/core/base_usecase/failures.dart';
import 'package:pet_app/core/base_usecase/usecase.dart';
import 'package:pet_app/domain/repos/pet_repository.dart';

class CancelAdoptionUseCase extends UseCase<bool, int>{
  final PetRepository repository;

  CancelAdoptionUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(int params) async {
    return await repository.cancelAdoption(params);
  }
}