import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_http/features/repositories/user_repository.dart';
import 'package:learn_bloc_http/features/views/auth/login/login_screen.dart';
import 'package:learn_bloc_http/my_app.dart';

import 'features/blocs/auth_bloc/auth_bloc.dart';

// import 'package:learn_bloc_http/features/repositories/auth_repo.dart';

// import 'package:learn_bloc_http/my_app.dart';

void main(List<String> args) {
  UserRepository userRepository = UserRepository();
  runApp(BlocProvider<AuthBloc>(
      create: (context) {
        return AuthBloc(userRepository)..add(AppStarted());
      },
      child: MyApp(
        userRepository: userRepository,
      )));
}
