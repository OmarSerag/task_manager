import 'package:task_manager/core/networking/api_error_handler.dart';
import 'package:task_manager/features/home/data/datasource/home_datasource.dart';
import 'package:task_manager/features/home/domain/entity/todos_entity.dart';
import 'package:task_manager/features/home/domain/repository/todos_repository.dart';

import '../../../../core/networking/api_result.dart';

class TodosRepositoryImpl implements TodosRepository {
  TodosRepositoryImpl(this._homeDataSource);

  final HomeDataSource _homeDataSource;

  @override
  Future<ApiResult<TodosEntity>> getAllTodos() async {
    try {
      final response = await _homeDataSource.getAllTodos();
      return ApiResult.success(
        TodosEntity.fromModel(response),
      );
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
