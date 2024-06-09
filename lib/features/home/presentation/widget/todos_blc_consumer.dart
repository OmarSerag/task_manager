import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/helpers/extensions.dart';
import 'package:task_manager/features/home/presentation/cubit/todos_cubit.dart';
import 'package:task_manager/features/home/presentation/cubit/todos_state.dart';
import 'package:task_manager/features/home/presentation/widget/todo_widget.dart';

import '../../../../core/theming/styles.dart';

class TodosBlocListener extends StatelessWidget {
  const TodosBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (state is Loading) {
          return const AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
        if (state is Success) {
          return TodoListWidget(response: state.data);
        }
        if (state is Error) {
          setupErrorState(context, state.error);
        }
        return const SizedBox.shrink();
      },
    );
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error,
          style: TextStyles.font15DarkBlueMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Got it',
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
