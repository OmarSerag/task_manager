import '../../../../core/networking/api_result.dart';
import '../entity/todos_entity.dart';

abstract class TodosRepository {
  Future<ApiResult<TodosEntity>> getAllTodos();
}
