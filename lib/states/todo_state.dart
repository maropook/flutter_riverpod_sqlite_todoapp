import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod_sqlite_todoapp/models/todo.dart';

part 'todo_state.freezed.dart';

@freezed
abstract class TodoState with _$TodoState {
  const factory TodoState({
    @Default([]) List<Todo> todos,
  }) = _TodoState;
}
