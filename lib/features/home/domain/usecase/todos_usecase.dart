import 'package:task_manager/core/networking/api_result.dart';
import 'package:task_manager/features/home/domain/repository/todos_repository.dart';

import '../entity/todos_entity.dart';

class TodosUseCase {
  final TodosRepository _todosRepository;

  TodosUseCase(this._todosRepository);

  Future<ApiResult<TodosEntity>> call() async =>
      await _todosRepository.getAllTodos();
}
