import 'package:pet_app/core/base_cubit/base_cubit.dart';
import 'package:pet_app/core/base_cubit/base_state.dart';

import '../../../domain/usecases/adopt_pet_use_case.dart';
import '../../../domain/usecases/cancel_adoption_use_case.dart';

part 'detail_page_state.dart';

class DetailPageCubit extends BaseCubit {
  final AdoptPetUseCase _adoptPetUseCase;
  final CancelAdoptionUseCase _cancelAdoptionUseCase;

  DetailPageCubit({
    required AdoptPetUseCase adoptPetUseCase,
    required CancelAdoptionUseCase cancelAdoptionUseCase,
  })  : _adoptPetUseCase = adoptPetUseCase,
        _cancelAdoptionUseCase = cancelAdoptionUseCase,
        super(DetailPageInitialState());

  Future<void> resetState() {
    emit(DetailPageInitialState());
    return Future.value();
  }

  Future<void> adoptPet(int id) async {
    try {
      final response = await _adoptPetUseCase.call(id);

      response.fold(
        (failure) {
          handleFailure(failure);
        },
        (response) {
          emit(AdoptPetSuccess(id: id));
        },
      );
    } catch (e) {
      emit(FailedState(e.toString()));
    }
  }

  Future<void> cancelAdoption(int id) async {
    try {
      final response = await _cancelAdoptionUseCase.call(id);

      response.fold(
        (failure) {
          handleFailure(failure);
        },
        (response) {
          emit(CancelAdoptionSuccess(id: id));
        },
      );
    } catch (e) {
      emit(FailedState(e.toString()));
    }
  }
}
