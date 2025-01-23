part of 'adopted_pets_page_cubit.dart';

class AdoptedPetsPageInitialState extends BaseState {
  @override
  List<Object?> get props => [];
}

class GetAdoptedPetListSuccess extends AdoptedPetsPageInitialState {
  final List<Pet> list;

  GetAdoptedPetListSuccess({required this.list});

  @override
  List<Object?> get props => [list];
}
