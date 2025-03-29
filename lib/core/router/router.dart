import 'package:go_router/go_router.dart';
import 'package:todo_riverpod/core/router/routes.dart';
import 'package:todo_riverpod/presentation/feature/home/home_screen.dart';
import 'package:todo_riverpod/presentation/feature/splash/splash_screen.dart';

final class AppRouter {
  AppRouter._();
  static GoRouter get router => _routes;

  static final _routes = GoRouter(
    routes: [
      GoRoute(
        path: Routes.initial.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.home.path,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
