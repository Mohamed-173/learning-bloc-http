import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_http/features/blocs/timer_bloc/timer_bloc.dart';
import 'package:learn_bloc_http/features/views/auth/home/opt_screen/otp_screen.dart';

class OtpPage extends StatelessWidget {
  final String phoneNo;
  final String name;
  final String email;
  final String password;

  final bool isActive;
  const OtpPage(
      {super.key,
      required this.phoneNo,
      required this.isActive,
      required this.name,
      required this.email,
      required this.password});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: (BlocProvider.of<TimerBloc>(context)),
      // value: !isActive
      //     ? (BlocProvider.of<TimerBloc>(context)
      //       ..add(TimerStarted(
      //           duration: 5,
      //           email: email,
      //           name: name,
      //           password: password,
      //           phoneNo: phoneNo)))
      // : (BlocProvider.of<TimerBloc>(context)),
      child: OtpScreen(
          phoneNo: phoneNo, email: email, name: name, password: password),
    );
  }
}
