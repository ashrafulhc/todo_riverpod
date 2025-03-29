import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:todo_riverpod/data/models/todo_response.dart';
import 'package:todo_riverpod/domain/entities/todo/todo_entity.dart';

part 'todo_remote_data_source.g.dart';

@RestApi()
@lazySingleton
abstract class TodoRemoteDataSource {
  @factoryMethod
  factory TodoRemoteDataSource(Dio dio) = _TodoRemoteDataSource;

  @GET('/todos')
  Future<TodoResponse> getTodos();

  @POST('/todos/add')
  Future<void> addTodo(@Body() TodoEntity todo);

  @DELETE('/todos/{id}')
  Future<void> deleteTodo(@Path('id') int id);
}
