import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/core/di/injection.dart';
import 'package:todo_riverpod/domain/entities/todo/todo_entity.dart';
import 'package:todo_riverpod/domain/usecases/todo/delete_todo_use_case.dart';
import 'package:todo_riverpod/domain/usecases/todo/get_all_todos_use_case.dart';
import 'package:todo_riverpod/domain/usecases/todo/add_todo_use_case.dart';
import 'package:todo_riverpod/presentation/feature/home/provider/operation_status_provider.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoNotifier extends _$TodoNotifier {
  @override
  Future<List<TodoEntity>> build() async {
    return _fetchTodos();
  }

  Future<List<TodoEntity>> _fetchTodos() async {
    return injector<GetAllTodosUseCase>().run();
  }

  Future<void> addTodo(TodoEntity todo) async {
    final operationNotifier =
        ref.read(operationStatusNotifierProvider.notifier);
    try {
      // Get current todos before operation
      final currentTodos = await future;

      operationNotifier.startOperation(OperationType.adding,
          message: 'Adding todo...');

      final addTodoUseCase = injector<AddTodoUseCase>();
      await addTodoUseCase.run(todo);

      state = AsyncValue.data([...currentTodos, todo]);

      operationNotifier.operationSuccess('Todo added successfully!');
    } catch (error) {
      operationNotifier
          .operationFailed('Failed to add todo: ${error.toString()}');
    }
  }

  Future<void> deleteTodo(TodoEntity todo) async {
    final operationNotifier =
        ref.read(operationStatusNotifierProvider.notifier);
    try {
      // Get current todos before operation
      final currentTodos = await future;

      operationNotifier.startOperation(OperationType.deleting,
          message: 'Deleting todo...');

      final deleteTodoUseCase = injector<DeleteTodoUseCase>();
      await deleteTodoUseCase.run(todo);

      state =
          AsyncValue.data(currentTodos.where((t) => t.id != todo.id).toList());

      operationNotifier.operationSuccess('Todo deleted successfully!');
    } catch (error) {
      operationNotifier
          .operationFailed('Failed to delete todo: ${error.toString()}');
    }
  }
}
