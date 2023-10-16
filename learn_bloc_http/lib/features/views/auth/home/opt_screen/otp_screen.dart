import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc_http/features/constant/app_const.dart';

import 'package:learn_bloc_http/features/widgets/big_text.dart';
import 'package:learn_bloc_http/features/widgets/custom_button.dart';
import 'package:learn_bloc_http/features/widgets/custom_textfield.dart';
import 'package:learn_bloc_http/features/widgets/small_text.dart';

import '../../../../blocs/timer_bloc/timer_bloc.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNo;

  final String name;
  final String email;
  final String password;
  const OtpScreen(
      {super.key,
      required this.phoneNo,
      required this.name,
      required this.email,
      required this.password});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const maxseconds = 120;
  int seconds = maxseconds;
  final _formkey = GlobalKey<FormState>();
  final f1 = TextEditingController();

  final f2 = TextEditingController();
  final f3 = TextEditingController();
  final f4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ))),
        body: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 20, left: 20, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BigText(text: "OTP Verifiction"),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SmallText(
                            text: "we are sent your code to ",
                            color: Colors.black45,
                            fontSize: 13),
                        // SmallText(
                        //     text: widget.phoneNo.replaceRange(
                        //         1, 6, "*" * (widget.phoneNo.length - 5)),
                        //     fontSize: 13,
                        //     color: Colors.black45),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(0)),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const SmallText(
                                text: "Change Phone number?",
                                color: Colors.blue,
                                fontSize: 13,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // const SizedBox(height: 25),

                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            height: 68,
                            width: 64,
                            child: CustomTextFormField(
                              controller: f1,
                              hintText: "",
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              type: TextFieldType.oneDigit,
                            )),
                        SizedBox(
                            height: 65,
                            width: 60,
                            child: CustomTextFormField(
                              controller: f2,
                              hintText: "",
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              type: TextFieldType.oneDigit,
                            )),
                        SizedBox(
                            height: 65,
                            width: 60,
                            child: CustomTextFormField(
                              controller: f3,
                              hintText: "",
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              type: TextFieldType.oneDigit,
                            )),
                        SizedBox(
                            height: 65,
                            width: 60,
                            child: CustomTextFormField(
                              controller: f4,
                              hintText: "",
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              type: TextFieldType.oneDigit,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SmallText(
                      text: "this code well expired in",
                      color: Colors.black45,
                      fontSize: 13),
                  const SizedBox(
                    width: 10,
                  ),
                  BlocBuilder<TimerBloc, TimerState>(
                    builder: (context, state) {
                      return state is TimerRunInProgress
                          ? const TimerText()
                          : const SizedBox();
                    },
                  ),
                ],
              ),
              BlocBuilder<TimerBloc, TimerState>(
                builder: (context, state) {
                  return SizedBox(
                    // height: 20,
                    // width: 30,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.all(0),
                            elevation: 0,
                            backgroundColor: Colors.white),
                        onPressed: state is TimerRunInProgress
                            ? null
                            : () {
                                BlocProvider.of<TimerBloc>(context).add(
                                    TimerStarted(
                                        duration: 120,
                                        email: widget.email,
                                        name: widget.name,
                                        password: widget.password,
                                        phoneNo: widget.phoneNo));
                              },
                        child: Text("Resend OTP Code")),
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    onPress: () {},
                    text: "Confirmation",
                    width: 150,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return SmallText(
      text: '$minutesStr:$secondsStr',
      fontSize: 13,
      color: Colors.blue,
    );
  }
}
