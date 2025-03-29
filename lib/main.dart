import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/core/di/injection.dart';
import 'package:todo_riverpod/presentation/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(
    const ProviderScope(
      child: TodoApp(),
    ),
  );
}
