import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/di/dependency_injection.dart';
import 'package:task_manager/core/routing/routes.dart';
import 'package:task_manager/features/home/presentation/cubit/todos_cubit.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/login/presentation/cubit/login_cubit.dart';
import '../../features/login/presentation/screen/login_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => DiContainer.getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<TodosCubit>(
            create: (context) => DiContainer.getIt<TodosCubit>()..getAllTodos(),
            child: const HomeScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
