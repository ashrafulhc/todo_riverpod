import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/core/di/injection.dart';
import 'package:todo_riverpod/domain/entities/todo/todo_entity.dart';
import 'package:todo_riverpod/domain/usecases/todo/delete_todo_use_case.dart';
import 'package:todo_riverpod/domain/usecases/todo/get_all_todos_use_case.dart';
import 'package:todo_riverpod/domain/usecases/todo/add_todo_use_case.dart';

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

  Future<void> refresh() async {
    // First set to loading state
    state = const AsyncValue.loading();

    // Then fetch and update state
    state = await AsyncValue.guard(_fetchTodos);
  }

  Future<void> addTodo(TodoEntity todo) async {
    try {
      // Get current todos before setting loading state
      final currentTodos = await future;

      // Set loading state
      state = const AsyncValue.loading();

      // Add the todo
      final addTodoUseCase = injector<AddTodoUseCase>();
      await addTodoUseCase.run(todo);

      // Update state with previous todos + new todo
      state = AsyncValue.data([...currentTodos, todo]);
    } catch (error, stackTrace) {
      // Handle errors properly
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteTodo(TodoEntity todo) async {
    final currentTodos = await future;
    state = const AsyncValue.loading();
    final deleteTodoUseCase = injector<DeleteTodoUseCase>();
    await deleteTodoUseCase.run(todo);
    state =
        AsyncValue.data(currentTodos.where((t) => t.id != todo.id).toList());
  }
}
