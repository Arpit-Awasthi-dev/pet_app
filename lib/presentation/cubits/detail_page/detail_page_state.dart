part of 'detail_page_cubit.dart';

class DetailPageInitialState extends BaseState {
  @override
  List<Object?> get props => [];
}

class AdoptPetSuccess extends DetailPageInitialState {
  final int index;
  final int id;

  AdoptPetSuccess({
    required this.index,
    required this.id,
  });

  @override
  List<Object?> get props => [index, id];
}

class CancelAdoptionSuccess extends DetailPageInitialState {
  final int index;
  final int id;

  CancelAdoptionSuccess({
    required this.index,
    required this.id,
  });

  @override
  List<Object?> get props => [index, id];
}
