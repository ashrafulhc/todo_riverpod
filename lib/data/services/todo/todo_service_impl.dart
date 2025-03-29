import 'package:injectable/injectable.dart';
import 'package:todo_riverpod/data/services/todo/sources/todo_remote_data_source.dart';
import 'package:todo_riverpod/domain/entities/todo/todo_entity.dart';
import 'package:todo_riverpod/domain/services/todo_service.dart';

@LazySingleton(as: TodoService)
class TodoServiceImpl implements TodoService {
  TodoServiceImpl(this._todoRemoteDataSource);
  final TodoRemoteDataSource _todoRemoteDataSource;

  @override
  Future<List<TodoEntity>> getAllTodos() async {
    final response = await _todoRemoteDataSource.getTodos();
    return response.todos;
  }

  @override
  Future<void> addTodo(TodoEntity todo) async {
    await _todoRemoteDataSource.addTodo(todo);
  }

  @override
  Future<void> deleteTodo(TodoEntity todo) async {
    await _todoRemoteDataSource.deleteTodo(todo.id);
  }
}
