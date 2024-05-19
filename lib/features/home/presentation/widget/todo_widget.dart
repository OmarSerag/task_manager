import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/theming/colors.dart';
import 'package:task_manager/features/home/domain/entity/todos_entity.dart';

class TodoListWidget extends StatelessWidget {
  final TodosEntity response;

  const TodoListWidget({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: response.todoList.length,
      itemBuilder: (context, index) {
        final element = response.todoList.elementAt(index);
        return contentWidget(todoEntity: element);
      },
    );
  }
}

Widget contentWidget({required TodoEntity todoEntity}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsManager.gray.withOpacity(.08),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                todoEntity.todo,
              ),
            ),
            Text('${todoEntity.complete ?? false}')
          ],
        ),
      ),
    ),
  );
}
