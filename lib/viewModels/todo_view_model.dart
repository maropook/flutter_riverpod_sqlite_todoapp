import 'package:flutter_riverpod_sqlite_todoapp/databases/todo_database.dart';
import 'package:flutter_riverpod_sqlite_todoapp/models/todo.dart';
import 'package:flutter_riverpod_sqlite_todoapp/repositories/todo_repository.dart';
import 'package:flutter_riverpod_sqlite_todoapp/states/todo_state.dart';
import 'package:riverpod/riverpod.dart';

final todoViewModelProvider =
    StateNotifierProvider<TodoViewModelProvider, TodoState>(
  (ref) => TodoViewModelProvider(
    ref.read,
    TodoRepository(TodoDatabase()),
  ),
);

class TodoViewModelProvider extends StateNotifier<TodoState> {
  TodoViewModelProvider(this._reader, this._todoRepository)
      : super(const TodoState()) {
    getTodos();
  }

  final Reader _reader;
  final TodoRepository _todoRepository;

  Future<void> addTodo(String title) async {
    final todo = await _todoRepository.addTodo(Todo(
      title: title,
      isDone: 0,
    ));

    state = state.copyWith(
      todos: [todo, ...state.todos],
    );
  }

  Future<void> getTodos() async {
    final todos = await _todoRepository.getTodos();

    state = state.copyWith(
      todos: todos,
    );
  }

  Future<void> changeStatus(Todo todo, int value) async {
    final newTodo = todo.copyWith(
      isDone: value,
    );

    await _todoRepository.updateTodo(newTodo);

    final todos = state.todos
        .map((todo) => todo.id == newTodo.id ? newTodo : todo)
        .toList();

    state = state.copyWith(
      todos: todos,
    );
  }

  Future<void> deleteTodo(int todoId) async {
    await _todoRepository.deleteTodo(todoId);

    final todos = state.todos.where((todo) => todo.id != todoId).toList();

    state = state.copyWith(
      todos: todos,
    );
  }
}
