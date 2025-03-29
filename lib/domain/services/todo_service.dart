import 'package:todo_riverpod/domain/entities/todo/todo_entity.dart';

abstract interface class TodoService {
  Future<List<TodoEntity>> getAllTodos();
  Future<void> addTodo(TodoEntity todo);
  Future<void> deleteTodo(TodoEntity todo);
}
