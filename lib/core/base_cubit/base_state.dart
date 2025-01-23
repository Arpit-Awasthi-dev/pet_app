import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();
}

class LoadingState extends BaseState {
  final bool loading;

  const LoadingState(this.loading);

  @override
  List<Object> get props => [loading];
}

class FailedState extends BaseState {
  final String message;

  const FailedState(this.message);

  @override
  List<Object> get props => [];
}

class VoidState extends BaseState {
  @override
  List<Object?> get props => [];
}
