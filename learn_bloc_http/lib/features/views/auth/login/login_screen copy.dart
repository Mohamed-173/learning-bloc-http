// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:learn_bloc_http/features/blocs/auth_bloc/auth_bloc.dart';
// import 'package:learn_bloc_http/features/blocs/login_bloc/login_bloc.dart';
// import 'package:learn_bloc_http/features/views/home_screen.dart';
// import 'package:learn_bloc_http/features/widgets/custom_button.dart';
// import 'package:learn_bloc_http/features/widgets/custom_textfield.dart';

// class LoginScreenCopy extends StatefulWidget {
//   LoginScreenCopy({super.key});

//   @override
//   State<LoginScreenCopy> createState() => _LoginScreenCopyState();
// }

// class _LoginScreenCopyState extends State<LoginScreenCopy> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formkey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
//         child: Form(
//           key: _formkey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Center(
//                 child: Text(
//                   "Login Page",
//                   style: TextStyle(
//                       fontSize: 50,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               CustomTextFormField(
//                 controller: emailController,
//                 hintText: "email",
//               ),
//               const SizedBox(height: 20),
//               CustomTextFormField(
//                 controller: passwordController,
//                 hintText: "password",
//                 isObscure: true,
//               ),
//               const SizedBox(height: 20),
//               CustomButton(
//                   onPress: () {
//                     emailController.text = "eve.holt@reqres.in";
//                     passwordController.text = "";
//                     // BlocProvider.of<LoginBloc>(context).add(
//                     //     LoginButtonPressed(
//                     //         email: emailController.text,
//                     //         password: passwordController.text));
//                   },
//                   text: "Submet"),
//               SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
