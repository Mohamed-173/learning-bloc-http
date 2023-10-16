import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_http/features/blocs/auth_bloc/auth_bloc.dart';
import 'package:learn_bloc_http/features/blocs/login_bloc/login_bloc.dart';
import 'package:learn_bloc_http/features/repositories/user_repository.dart';
import 'package:learn_bloc_http/features/views/auth/home/home_screen.dart';
import 'package:learn_bloc_http/features/views/auth/login/login_form.dart';
import 'package:learn_bloc_http/features/widgets/custom_button.dart';
import 'package:learn_bloc_http/features/widgets/custom_textfield.dart';

import '../../../blocs/check_bloc/check_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, required this.userRepository});

  final UserRepository userRepository;

  // final emailController = TextEditingController();

  // final passwordController = TextEditingController();

  // final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocProvider(
            create: (context) => CheckBloc(userRepository),
            child: BlocProvider(
              create: (context) => LoginBloc(
                userRepository: userRepository,
                authBloc: BlocProvider.of<AuthBloc>(context),
              ),
              child: LoginForm(userRepository: userRepository),
            ),
          )),
    );
  }
}
