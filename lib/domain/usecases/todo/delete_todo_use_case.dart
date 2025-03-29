import 'package:injectable/injectable.dart';
import 'package:todo_riverpod/domain/entities/todo/todo_entity.dart';
import 'package:todo_riverpod/domain/services/todo_service.dart';

@LazySingleton()
class DeleteTodoUseCase {
  DeleteTodoUseCase(this._todoService);
  final TodoService _todoService;

  Future<void> run(TodoEntity todo) async {
    await _todoService.deleteTodo(todo);
  }
}
