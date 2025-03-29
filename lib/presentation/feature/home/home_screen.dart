import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/domain/entities/todo/todo_entity.dart';
import 'package:todo_riverpod/presentation/feature/home/provider/todo_provider.dart';
import 'package:todo_riverpod/presentation/feature/home/widgets/add_todo_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: todosAsync.when(
        data: (todos) => _buildTodoList(todos, ref),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _showAddTodoDialog(context, ref);
            },
            heroTag: 'addTodo',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              ref.read(todoNotifierProvider.notifier).refresh();
            },
            heroTag: 'refreshTodos',
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList(List<TodoEntity> todos, WidgetRef ref) {
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

  void _showAddTodoDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AddTodoDialog(
        onAdd: (todo) {
          ref.read(todoNotifierProvider.notifier).addTodo(todo);
        },
      ),
    );
  }
}
