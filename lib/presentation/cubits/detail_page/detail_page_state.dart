part of 'detail_page_cubit.dart';

class DetailPageInitialState extends BaseState {
  @override
  List<Object?> get props => [];
}

class AdoptPetSuccess extends DetailPageInitialState {
  final int id;

  AdoptPetSuccess({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

class CancelAdoptionSuccess extends DetailPageInitialState {
  final int id;

  CancelAdoptionSuccess({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
