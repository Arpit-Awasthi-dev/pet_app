import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_sources/pet_local_data_source.dart';
import '../data/repo_impl/pet_repo_impl.dart';
import '../domain/repos/pet_repository.dart';
import '../domain/usecases/adopt_pet_use_case.dart';
import '../domain/usecases/cancel_adoption_use_case.dart';
import '../domain/usecases/get_adopted_pet_list_use_case.dart';
import '../domain/usecases/get_pet_list_use_case.dart';
import '../presentation/cubits/adopted_pets_page/adopted_pets_page_cubit.dart';
import '../presentation/cubits/detail_page/detail_page_cubit.dart';
import '../presentation/cubits/home_page/home_page_cubit.dart';
import 'db/database_service.dart';
import 'navigation/navigation_service.dart';

//Service locator instance
final sl = GetIt.instance;

Future<void> init() async {
  /// ---------- Cubits ------------
  sl.registerFactory(() => HomePageCubit(getPetListUseCase: sl()));
  sl.registerFactory(() => DetailPageCubit(
        adoptPetUseCase: sl(),
        cancelAdoptionUseCase: sl(),
      ));
  sl.registerFactory(
      () => AdoptedPetsPageCubit(getAdoptedPetListUseCase: sl()));

  /// ----------- Use Cases ----------
  sl.registerLazySingleton(() => GetPetListUseCase(repository: sl()));
  sl.registerLazySingleton(() => AdoptPetUseCase(repository: sl()));
  sl.registerLazySingleton(() => CancelAdoptionUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAdoptedPetListUseCase(repository: sl()));

  /// ----------- Repositories -----------
  sl.registerLazySingleton<PetRepository>(
    () => PetRepoImpl(
      localDataSource: sl(),
    ),
  );

  /// ----------- Data Sources ----------
  sl.registerLazySingleton<PetLocalDataSource>(
    () => PetLocalDataSourceImpl(service: sl()),
  );

  /// ------------ Others -------------
  sl.registerLazySingleton(() => NavigationService());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DatabaseService.instance);
}
