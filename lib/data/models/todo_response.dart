import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_riverpod/domain/entities/todo/todo_entity.dart';

part 'todo_response.freezed.dart';
part 'todo_response.g.dart';

@freezed
class TodoResponse with _$TodoResponse {
  const factory TodoResponse({
    required List<TodoEntity> todos,
    required int total,
    required int skip,
    required int limit,
  }) = _TodoResponse;

  factory TodoResponse.fromJson(Map<String, dynamic> json) =>
      _$TodoResponseFromJson(json);
}
