import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:learn_bloc_http/features/blocs/login_bloc/login_bloc.dart';
import 'package:learn_bloc_http/features/constant/app_const.dart';
import 'package:learn_bloc_http/features/repositories/user_repository.dart';
import 'package:learn_bloc_http/features/views/auth/register/register_screen.dart';

import '../../../blocs/check_bloc/check_bloc.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;
  final TextEditingController? controller;
  const LoginForm({Key? key, required this.userRepository, this.controller})
      : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(userRepository, controller);
}

class _LoginFormState extends State<LoginForm> {
  _LoginFormState(
      UserRepository userRepository, TextEditingController? controller);
  final phoneNoController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  _onBlocLoginPressed({required BuildContext context}) {
    BlocProvider.of<LoginBloc>(context)
        .add(LoginButtonPressed(phonNo: phoneNoController.text));
  }

  _onBlocEmailChecked({required BuildContext context}) {
    BlocProvider.of<CheckBloc>(context).add(
      CheckEmailExistEvent(
        emailController.text,
      ),
    );
  }

  _onBlocPhoneChecked({required BuildContext context}) {
    BlocProvider.of<CheckBloc>(context).add(
      CheckUserExistEvent(
        phoneNoController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckBloc, CheckState>(
      listener: (context, state1) {
        if (state1 is CheckSuccessfully) {
          Fluttertoast.showToast(
              msg:
                  "user extest and vale of Success ${state1.message} need be true ");
        } else if (state1 is CheckFailed) {
          if (state1.error.toLowerCase() == "false") {
            // Fluttertoast.showToast(
            //     msg: "user not exist and value of Success is: false");
            log(state1.error);

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterScreen(
                      userRepository: widget.userRepository,
                      controller: phoneNoController,
                    )));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("second ${state1.error.toString()}")));
            log(state1.error);
          }
        }
      },
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state2) {
          if (state2 is LoginFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state2.error)));
          }
        },
        child: BlocBuilder<CheckBloc, CheckState>(
          builder: (context, state1) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "Login Page",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: phoneNoController,
                      hintText: "phoneNo",
                      type: TextFieldType.phoneNo,
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: state1 is CheckSuccessfully,
                      child: CustomTextFormField(
                        controller: passwordController,
                        hintText: "password",
                        type: TextFieldType.password,
                        isObscure: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return CustomButton(
                            onPress: () {
                              if (_formkey.currentState!.validate()) {
                                state1 is CheckSuccessfully
                                    ? _onBlocLoginPressed(context: context)
                                    : _onBlocPhoneChecked(context: context);
                              }
                            },
                            text: "Submet");
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        onPress: () {
                          // Focus.of(context).unfocus();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterScreen(
                                    userRepository: widget.userRepository,
                                    controller: phoneNoController,
                                  )));
                        },
                        text: "Register",
                        color: Colors.blue,
                        fontColor: Colors.white),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: state1 is CheckLoading
                          ? const CircularProgressIndicator(
                              color: Colors.blue,
                              strokeWidth: 4,
                            )
                          : null,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
