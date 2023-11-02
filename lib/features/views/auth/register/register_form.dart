import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_http/features/blocs/register_bloc/register_bloc.dart';
import 'package:learn_bloc_http/features/constant/app_const.dart';
import 'package:learn_bloc_http/features/repositories/user_repository.dart';
import 'package:learn_bloc_http/features/views/auth/home/opt_screen/otp_page.dart';
import 'package:learn_bloc_http/features/widgets/custom_button.dart';
import 'package:learn_bloc_http/features/widgets/custom_textfield.dart';

import '../../../blocs/timer_bloc/timer_bloc.dart';
import '../../../widgets/ticker.dart';
import '../home/opt_screen/otp_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterForm extends StatefulWidget {
  final UserRepository userRepository;
  TextEditingController? controller;
  RegisterForm({
    Key? key,
    required this.userRepository,
    this.controller,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  int i = 0;
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final rePasswordController = TextEditingController();
  final phoneNoController = TextEditingController();
  FocusNode n = FocusNode();
  @override
  void dispose() {
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<TimerBloc, TimerState>(
      listener: (context, state) {
        if (state is TimerRunComplete) {}
      },
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailed) {
            if (state is RegisterSuccessfuly) {
              Fluttertoast.showToast(
                  msg: "the Registration successfylly submited",
                  gravity: ToastGravity.TOP);
            } else if (state is RegisterFailed) {
              if (state.error != null) {
                // log("here i am the problem");
                Fluttertoast.showToast(
                    msg: "${state.error?.toLowerCase()}",
                    gravity: ToastGravity.TOP);
                // if (i < 3) {
                //   BlocProvider.of<RegisterBloc>(context).add(
                //       OnButtonPressedEvent(
                //           email: emailController.text,
                //           name: nameController.text,
                //           password: passwordController.text,
                //           phoneNo: phoneNoController.text));
                // }
              } else {
                Fluttertoast.showToast(
                    msg: "the registration not denayed",
                    gravity: ToastGravity.TOP);
                //! i dont know why i write those line codes
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => RegisterScreen(
                //           userRepository: widget.userRepository,
                //           controller: phoneNumber,
                //         )));
              }
            }
            // Fluttertoast.showToast(
            //     msg: "the Registration not successfuly submited",
            //     gravity: ToastGravity.TOP);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Center(
            child: Form(
              key: _formkey,
              child: BlocBuilder<RegisterBloc, RegisterState>(
                builder: (registerContext, registerState) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<TimerBloc, TimerState>(
                          builder: (timerContext, timerState) {
                            return Text("${timerState.duration}");
                          },
                        ),
                        const Text(
                          "Register screen",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          type: TextFieldType.name,
                          hintText: "User Name",
                          controller: nameController,
                          function: () {
                            BlocProvider.of<TimerBloc>(context)
                                .add(const TimerReset());
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          type: TextFieldType.email,
                          hintText: "Email...",
                          controller: emailController,
                          function: () {
                            BlocProvider.of<TimerBloc>(context)
                                .add(const TimerReset());
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          focusNode: n,
                          type: TextFieldType.phoneNo,
                          hintText: "Phone No",
                          controller: widget.controller ?? phoneNoController,
                          function: () {
                            BlocProvider.of<TimerBloc>(context)
                                .add(const TimerReset());
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          type: TextFieldType.password,
                          hintText: "Password",
                          rePassword: rePasswordController.text,
                          controller: passwordController,
                          function: () {
                            BlocProvider.of<TimerBloc>(context)
                                .add(const TimerReset());
                            FocusScope.of(context).nextFocus();
                          },
                          isObscure: true,
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          type: TextFieldType.rePassword,
                          rePassword: passwordController.text,
                          hintText: "RePassword",
                          controller: rePasswordController,
                          function: () {
                            BlocProvider.of<TimerBloc>(context)
                                .add(const TimerReset());
                            FocusScope.of(context).nextFocus();
                          },
                          isObscure: true,
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<TimerBloc, TimerState>(
                          builder: (context, timerState) {
                            int i = 0;
                            //! no need to close manualy because wee need it

                            log("$i  ${timerState.runtimeType}");
                            log("$i  ${registerState.runtimeType}");

                            i++;
                            return CustomButton(
                              onPress: () async {
                                if (_formkey.currentState!.validate()) {
                                  log("we are done");
                                  log(registerState.toString());

                                  await BlocProvider.of<RegisterBloc>(context)
                                    ..add(OnButtonPressedEvent(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phoneNo: phoneNoController.text,
                                      rePassword: rePasswordController.text,
                                    ));

                                  bool? focus = false;

                                  if (registerState is RegisterSuccessfuly) {
                                    focus = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (newcontext) =>
                                                BlocProvider.value(
                                                  value: timerState
                                                          is TimerRunInProgress
                                                      ? BlocProvider.of<
                                                          TimerBloc>(context)
                                                      : (BlocProvider.of<
                                                          TimerBloc>(context)
                                                        ..add(TimerStarted(
                                                          name: nameController
                                                              .text,
                                                          email: emailController
                                                              .text,
                                                          password:
                                                              passwordController
                                                                  .text,
                                                          phoneNo:
                                                              phoneNoController
                                                                  .text,
                                                          duration: 120,
                                                        ))),
                                                  child: OtpPage(
                                                    phoneNo:
                                                        phoneNoController.text,
                                                    email: emailController.text,
                                                    name: nameController.text,
                                                    password:
                                                        passwordController.text,
                                                    isActive: timerState
                                                            is TimerRunInProgress
                                                        ? true
                                                        : false,
                                                  ),
                                                )));
                                  } else {
                                    log("we are failed");
                                    // return;
                                  }
                                  // await Future.delayed(Duration(seconds: 5));

                                  if (focus == true) {
                                    FocusScope.of(context).requestFocus(n);
                                  }
                                }
                              },
                              text: "Confirm Registeration",
                              color: Colors.blue,
                              fontColor: Colors.white,
                            );
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: registerState is RegisterLoading
                              ? Container(child: CircularProgressIndicator())
                              : null,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
