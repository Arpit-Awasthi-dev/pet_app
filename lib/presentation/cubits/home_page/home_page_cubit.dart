import 'package:pet_app/core/base_cubit/base_cubit.dart';
import 'package:pet_app/core/base_cubit/base_state.dart';

import '../../../domain/entities/pet.dart';
import '../../../domain/usecases/get_pet_list_use_case.dart';

part 'home_page_state.dart';

class HomePageCubit extends BaseCubit {
  final GetPetListUseCase _getPetListUseCase;

  HomePageCubit({required GetPetListUseCase getPetListUseCase})
      : _getPetListUseCase = getPetListUseCase,
        super(HomePageInitialState());

  Future<void> getPetList({
    required int pageNo,
    required String query,
    required bool clearList,
  }) async {
    try {
      var request = GetPetListParams(
        pageNo: pageNo,
        query: query,
      );
      final response = await _getPetListUseCase.call(request);

      response.fold(
        (failure) {
          handleFailure(failure);
        },
        (response) {
          final List<Pet> list = [];

          if (state is GetPetListSuccess && !clearList) {
            list.addAll((state as GetPetListSuccess).petList);
          }

          list.addAll(response);

          emit(GetPetListSuccess(
            petList: list,
            hasNextPage: response.length == request.limit,
          ));
        },
      );
    } catch (e) {
      emit(FailedState(e.toString()));
    }
  }

  Future<void> updatePetListAdoptionStatus(
    int index,
    int id,
    bool adoptionStatus,
  ) {
    List<Pet> list = [];
    bool hasNextPage = false;
    if (state is GetPetListSuccess) {
      list.addAll((state as GetPetListSuccess).petList);
      hasNextPage = (state as GetPetListSuccess).hasNextPage;
    }

    list[index].isAdopted = adoptionStatus;

    emit(VoidState());
    emit(GetPetListSuccess(
      petList: list,
      hasNextPage: hasNextPage,
    ));
    return Future.value();
  }
}
