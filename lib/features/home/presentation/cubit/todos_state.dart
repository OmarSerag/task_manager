import 'package:freezed_annotation/freezed_annotation.dart';

part 'todos_state.freezed.dart';

@freezed
class TodosState<T> with _$TodosState<T> {
  const factory TodosState.initial() = _Initial;

  const factory TodosState.loading() = Loading;
  const factory TodosState.success(T data) = Success<T>;
  const factory TodosState.error({required String error}) = Error;
}
