import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/domain/entities/todo/todo_entity.dart';
import 'package:todo_riverpod/presentation/feature/home/provider/todo_provider.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key, required this.todos, required this.ref});
  final List<TodoEntity> todos;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return ListTile(
          title: Text(todo.todo),
          leading: Checkbox(
            value: todo.completed,
            onChanged: null,
          ),
          trailing: IconButton(
            onPressed: () {
              ref.read(todoNotifierProvider.notifier).deleteTodo(todo);
            },
            icon: const Icon(Icons.delete_outline),
          ),
        );
      },
    );
  }
}
