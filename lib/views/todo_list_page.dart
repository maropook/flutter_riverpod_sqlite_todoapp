import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod_sqlite_todoapp/models/todo.dart';
import 'package:flutter_riverpod_sqlite_todoapp/viewModels/todo_view_model.dart';
import 'package:flutter_riverpod_sqlite_todoapp/views/todo_add_page.dart';

class TodoListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: _todoList(ref),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) {
                return TodoAddPage();
              },
              fullscreenDialog: true,
            ),
          );
        },
      ),
    );
  }

  Widget _todoList(WidgetRef ref) {
    final TodoViewModelProvider todoViewModel =
        ref.read(todoViewModelProvider.notifier);
    final todoState = ref.watch(todoViewModelProvider);

    return ListView.builder(
      itemCount: todoState.todos.length,
      itemBuilder: (BuildContext context, int index) {
        final todo = todoState.todos[index];

        return _todoItem(todo, index, todoViewModel);
      },
    );
  }

  Widget _todoItem(Todo todo, int index, TodoViewModelProvider todoViewModel) {
    return Slidable(
      actionPane: const SlidableScrollActionPane(),
      secondaryActions: [
        IconSlideAction(
          caption: '削除',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
            await todoViewModel.deleteTodo(todo.id!);
          },
        ),
      ],
      child: CheckboxListTile(
        title: Text(
          todo.title,
          style: TextStyle(
              decoration: todo.isDone == 1
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        value: todo.isDone == 1 ? true : false,
        onChanged: (value) {
          todoViewModel.changeStatus(todo, value! ? 1 : 0);
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
