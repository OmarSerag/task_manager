import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/home/domain/usecase/todos_usecase.dart';
import 'package:task_manager/features/home/presentation/cubit/todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final TodosUseCase _todosUseCase;

  TodosCubit(this._todosUseCase) : super(const TodosState.initial());

  void getAllTodos() async {
    emit(const TodosState.loading());
    final response = await _todosUseCase.call();
    response.when(
      success: (data) {
        emit(TodosState.success(data));
      },
      failure: (error) {
        emit(TodosState.error(error: error.apiErrorModel.message ?? ""));
      },
    );
  }
}
