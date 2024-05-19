import 'package:freezed_annotation/freezed_annotation.dart';

part 'todos_model.g.dart';

@JsonSerializable()
class TodosModel {
  final int total, skip, limit;
  @JsonKey(name: "todos")
  final List<TodoModel> todoList;

  TodosModel(this.total, this.skip, this.limit, this.todoList);

  factory TodosModel.fromJson(Map<String, dynamic> json) =>
      _$TodosModelFromJson(json);
}

@JsonSerializable()
class TodoModel {
  final int id;
  final String todo;
  @Default(false)
  final bool? complete;
  final int userId;

  TodoModel(this.id, this.todo, this.complete, this.userId);

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
}
