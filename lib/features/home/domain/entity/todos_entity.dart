import 'package:task_manager/features/home/data/models/todos_model.dart';

class TodosEntity {
  final int total, skip, limit;
  final List<TodoEntity> todoList;

  TodosEntity({
    required this.total,
    required this.skip,
    required this.limit,
    required this.todoList,
  });

  factory TodosEntity.fromModel(TodosModel todosModel) => TodosEntity(
        total: todosModel.total,
        skip: todosModel.skip,
        limit: todosModel.limit,
        todoList:
            todosModel.todoList.map((e) => TodoEntity.fromModel(e)).toList(),
      );
}

class TodoEntity {
  final int? id;
  final String todo;
  final bool? complete;
  final int userId;

  TodoEntity({
    required this.id,
    required this.todo,
    this.complete,
    required this.userId,
  });

  factory TodoEntity.fromModel(TodoModel todoModel) => TodoEntity(
        id: todoModel.id,
        todo: todoModel.todo,
        complete: todoModel.complete,
        userId: todoModel.userId,
      );
}
