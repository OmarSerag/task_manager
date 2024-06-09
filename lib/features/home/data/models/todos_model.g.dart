// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodosModel _$TodosModelFromJson(Map<String, dynamic> json) => TodosModel(
      (json['total'] as num).toInt(),
      (json['skip'] as num).toInt(),
      (json['limit'] as num).toInt(),
      (json['todos'] as List<dynamic>)
          .map((e) => TodoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodosModelToJson(TodosModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
      'todos': instance.todoList,
    };

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel(
      (json['id'] as num).toInt(),
      json['todo'] as String,
      json['complete'] as bool?,
      (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
      'id': instance.id,
      'todo': instance.todo,
      'complete': instance.complete,
      'userId': instance.userId,
    };
