import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_http/features/blocs/auth_bloc/auth_bloc.dart';
import 'package:learn_bloc_http/features/blocs/register_bloc/register_bloc.dart';
import 'package:learn_bloc_http/features/blocs/timer_bloc/timer_bloc.dart';
import 'package:learn_bloc_http/features/repositories/user_repository.dart';
import 'package:learn_bloc_http/features/views/auth/register/register_form.dart';
import 'package:learn_bloc_http/features/widgets/ticker.dart';

class RegisterScreen extends StatelessWidget {
  UserRepository userRepository;
  final TextEditingController? controller;
  RegisterScreen({
    Key? key,
    required this.userRepository,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black)),
        ),
        body: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
            userRepository,
            BlocProvider.of<AuthBloc>(context),
          ),
          child: BlocProvider<TimerBloc>(
            create: (context) => TimerBloc(ticker: const Ticker()),
            child: RegisterForm(
              userRepository: userRepository,
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }
}
