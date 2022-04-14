import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod_sqlite_todoapp/viewModels/todo_view_model.dart';

class TodoAddPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TodoViewModelProvider todoViewModel =
        ref.read(todoViewModelProvider.notifier);

    final _titleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _titleController,
          ),
          ElevatedButton(
            onPressed: () async {
              await todoViewModel.addTodo(_titleController.text);

              Navigator.pop(context);
            },
            child: const Text('追加'),
          ),
        ],
      ),
    );
  }
}
