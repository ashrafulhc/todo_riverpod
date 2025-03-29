// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/services/todo/sources/todo_remote_data_source.dart' as _i777;
import '../../data/services/todo/todo_service_impl.dart' as _i445;
import '../../domain/services/todo_service.dart' as _i1023;
import '../../domain/usecases/todo/add_todo_use_case.dart' as _i742;
import '../../domain/usecases/todo/delete_todo_use_case.dart' as _i994;
import '../../domain/usecases/todo/get_all_todos_use_case.dart' as _i98;
import '../network/dio_config.dart' as _i150;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioConfig = _$DioConfig();
    gh.lazySingleton<_i361.Dio>(() => dioConfig.dio);
    gh.lazySingleton<_i777.TodoRemoteDataSource>(
        () => _i777.TodoRemoteDataSource(gh<_i361.Dio>()));
    gh.lazySingleton<_i1023.TodoService>(
        () => _i445.TodoServiceImpl(gh<_i777.TodoRemoteDataSource>()));
    gh.lazySingleton<_i98.GetAllTodosUseCase>(
        () => _i98.GetAllTodosUseCase(gh<_i1023.TodoService>()));
    gh.lazySingleton<_i994.DeleteTodoUseCase>(
        () => _i994.DeleteTodoUseCase(gh<_i1023.TodoService>()));
    gh.lazySingleton<_i742.AddTodoUseCase>(
        () => _i742.AddTodoUseCase(gh<_i1023.TodoService>()));
    return this;
  }
}

class _$DioConfig extends _i150.DioConfig {}
