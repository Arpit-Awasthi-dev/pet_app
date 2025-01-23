import 'package:flutter_bloc/flutter_bloc.dart';

import '../base_usecase/failures.dart';
import 'base_state.dart';

abstract class BaseCubit extends Cubit<BaseState> {
  BaseCubit(super.state);

  void handleFailure(Failure failure) {
    if (failure is FailedState) {
      emit(FailedState(failure.message));
    }
  }
}