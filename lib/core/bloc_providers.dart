import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import '../presentation/cubits/adopted_pets_page/adopted_pets_page_cubit.dart';
import '../presentation/cubits/detail_page/detail_page_cubit.dart';
import '../presentation/cubits/home_page/home_page_cubit.dart';
import 'injection_container.dart' as di;

class BlocProviders {
  static List<SingleChildWidget> toGenerateProviders() {
    return [
      BlocProvider(
        create: (_) => di.sl<HomePageCubit>(),
      ),
      BlocProvider(
        create: (_) => di.sl<DetailPageCubit>(),
      ),
      BlocProvider(
        create: (_) => di.sl<AdoptedPetsPageCubit>(),
      ),
    ];
  }
}