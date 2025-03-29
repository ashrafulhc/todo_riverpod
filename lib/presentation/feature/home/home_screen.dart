import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/presentation/feature/home/provider/operation_status_provider.dart';
import 'package:todo_riverpod/presentation/feature/home/provider/todo_provider.dart';
import 'package:todo_riverpod/presentation/feature/home/widgets/add_todo_dialog.dart';
import 'package:todo_riverpod/presentation/feature/home/widgets/todo_list_view.dart';
import 'package:todo_riverpod/presentation/widgets/operation_loader.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoNotifierProvider);
    final operationStatus = ref.watch(operationStatusNotifierProvider);

    ref.listen(
      operationStatusNotifierProvider,
      (previous, current) {
        if (!current.isLoading &&
            current.message != null &&
            (previous?.isLoading == true ||
                previous?.message != current.message)) {
          context.showOperationResult(current);

          Future.delayed(const Duration(seconds: 2), () {
            ref.read(operationStatusNotifierProvider.notifier).reset();
          });
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          todosAsync.when(
            data: (todos) => TodoListView(todos: todos, ref: ref),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stack) => Center(
              child: Text('Error: $error'),
            ),
          ),
          if (operationStatus.isLoading)
            const Positioned(
              top: 16,
              child: OperationLoader(),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _showAddTodoDialog(context, ref);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
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
