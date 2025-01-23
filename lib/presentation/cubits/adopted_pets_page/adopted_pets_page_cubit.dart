import 'package:pet_app/core/base_usecase/usecase.dart';

import '../../../core/base_cubit/base_cubit.dart';
import '../../../core/base_cubit/base_state.dart';
import '../../../domain/entities/pet.dart';
import '../../../domain/usecases/get_adopted_pet_list_use_case.dart';

part 'adopted_pets_page_state.dart';

class AdoptedPetsPageCubit extends BaseCubit {
  final GetAdoptedPetListUseCase _getAdoptedPetListUseCase;

  AdoptedPetsPageCubit(
      {required GetAdoptedPetListUseCase getAdoptedPetListUseCase})
      : _getAdoptedPetListUseCase = getAdoptedPetListUseCase,
        super(AdoptedPetsPageInitialState());

  Future<void> getAdoptedPetList() async {
    try {
      final response = await _getAdoptedPetListUseCase.call(NoParams());

      response.fold(
        (failure) {
          handleFailure(failure);
        },
        (response) {
          emit(GetAdoptedPetListSuccess(list: response));
        },
      );
    } catch (e) {
      emit(FailedState(e.toString()));
    }
  }
}
