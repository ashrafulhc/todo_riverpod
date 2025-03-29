import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_riverpod/domain/entities/todo/todo_entity.dart';
import 'package:todo_riverpod/domain/services/todo_service.dart';

@lazySingleton
final class GetAllTodosUseCase {
  GetAllTodosUseCase(this._todoService) {
    debugPrint('GetAllTodosUseCase instance created');
  }

  final TodoService _todoService;

  Future<List<TodoEntity>> run() async {
    return _todoService.getAllTodos();
  }
}
