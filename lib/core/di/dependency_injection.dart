import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager/core/networking/dio_factory.dart';
import 'package:task_manager/features/home/data/datasource/home_datasource.dart';
import 'package:task_manager/features/home/data/repository_impl/todos_repository_impl.dart';
import 'package:task_manager/features/home/domain/repository/todos_repository.dart';
import 'package:task_manager/features/home/domain/usecase/todos_usecase.dart';
import 'package:task_manager/features/home/presentation/cubit/todos_cubit.dart';
import 'package:task_manager/features/login/data/datasource/login_datasource.dart';
import 'package:task_manager/features/login/data/repository_impl/login_repository_impl.dart';
import 'package:task_manager/features/login/domain/repository/login_repository.dart';
import 'package:task_manager/features/login/domain/usecase/login_use_case.dart';
import 'package:task_manager/features/login/presentation/cubit/login_cubit.dart';

class DiContainer {
  DiContainer._();

  static final getIt = GetIt.instance;
  static final instance = DiContainer._();

  Future<void> setup() async {
    final dio = DioFactory.getDio();
    _login(dio);
    _home(dio);
  }

  void _login(Dio dio) {
    ///data///
    getIt.registerFactory<LoginDataSource>(() => LoginDataSource(dio));

    ///domain///
    getIt.registerFactory<LoginRepository>(
      () => LoginRepositoryImpl(
        getIt<LoginDataSource>(),
      ),
    );
    getIt.registerFactory<LoginUseCase>(
      () => LoginUseCase(
        getIt<LoginRepository>(),
      ),
    );

    ///cubit///
    getIt.registerFactory<LoginCubit>(
      () => LoginCubit(
        getIt<LoginUseCase>(),
      ),
    );
  }

  void _home(Dio dio) {
    ///data///
    getIt.registerFactory<HomeDataSource>(() => HomeDataSource(dio));

    ///domain///
    getIt.registerFactory<TodosRepository>(
      () => TodosRepositoryImpl(
        getIt<HomeDataSource>(),
      ),
    );
    getIt.registerFactory<TodosUseCase>(
      () => TodosUseCase(
        getIt<TodosRepository>(),
      ),
    );

    ///cubit///
    getIt.registerLazySingleton<TodosCubit>(
      () => TodosCubit(
        getIt<TodosUseCase>(),
      ),
    );
  }
}
