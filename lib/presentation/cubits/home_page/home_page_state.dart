part of 'home_page_cubit.dart';

class HomePageInitialState extends BaseState {
  @override
  List<Object?> get props => [];
}

class GetPetListSuccess extends HomePageInitialState {
  final List<Pet> petList;
  final bool hasNextPage;
  final DateTime stamp = DateTime.now();

  GetPetListSuccess({
    required this.petList,
    required this.hasNextPage,
  });

  @override
  List<Object?> get props => [stamp];
}
