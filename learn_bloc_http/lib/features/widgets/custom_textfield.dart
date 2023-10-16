import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
import 'package:learn_bloc_http/features/constant/app_const.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  TextEditingController? controller;
  bool? isObscure = false;
  String? hintText;
  String? rePassword;
  VoidCallback? function;
  TextFieldType? type;
  TextAlign? textAlign;
  int? maxLength;
  FocusNode? focusNode;

  CustomTextFormField({
    Key? key,
    this.controller,
    this.isObscure,
    this.hintText,
    this.function,
    this.type,
    this.textAlign,
    this.maxLength,
    this.focusNode,
    this.rePassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // maxLength: maxLength,

      focusNode: focusNode,
      onEditingComplete: function,
      onChanged: (value) {
        if (type == TextFieldType.oneDigit) {
          if (value.length == 1) {
            // log("i need be done?");// you are doned (:)
            FocusScope.of(context).nextFocus();
            return;
          }
        } else if (type == TextFieldType.phoneNo) {
          // function;
        }
      },
      inputFormatters:
          (type == TextFieldType.oneDigit || type == TextFieldType.phoneNo)
              ? [
                  LengthLimitingTextInputFormatter(maxLength),
                  FilteringTextInputFormatter.digitsOnly,
                ]
              : type == TextFieldType.name
                  ? [
                      LengthLimitingTextInputFormatter(20),
                      // FilteringTextInputFormatter.digitsOnly,
                    ]
                  : null,
      controller: controller,
      key: key,
      keyboardType: type == TextFieldType.email
          ? TextInputType.emailAddress
          : type == TextFieldType.phoneNo
              ? TextInputType.phone
              : type == TextFieldType.oneDigit
                  ? TextInputType.number
                  : TextInputType.name,
      decoration: InputDecoration(
        // alignLabelWithHint: false,

        contentPadding: maxLength != null ? EdgeInsets.all(5) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.5),
          borderSide: const BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.5),
          borderSide: const BorderSide(color: Colors.black38),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.5),
          borderSide: const BorderSide(color: Colors.black38),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.5),
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintText: hintText ?? "hintText",
      ),
      textAlign: textAlign ?? TextAlign.start,
      obscureText: isObscure ?? false,
      validator: (value) {
        if (value == null || value == "") {
          return "$hintText not be empty";
        } else {
          if (type == TextFieldType.phoneNo) {
            String pattern = r'^7\d{9}$';
            RegExp regExp = new RegExp(pattern);
            if (value.length == 0) {
              return 'Please enter mobile number';
            } else if (!regExp.hasMatch(value)) {
              return 'Please enter valid mobile number like 7x xxx xxxx';
            }
          } else if (type == TextFieldType.password) {
            if (value.length < 6) {
              return "lenth must not be less than 6 digit";
            }
          } else if (type == TextFieldType.email) {
            String pattern =
                r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

            RegExp regExp = new RegExp(pattern);
            if (value.length == 0) {
              return 'Please enter mobile number';
            } else if (!regExp.hasMatch(value)) {
              return 'Please enter valid email address like example@example.example';
            }
          } else if (type == TextFieldType.rePassword) {
            if (value.length < 6) {
              return "lenth must not be less than 6 digit";
            }
            // log("$value + $rePassword");
            if (value != rePassword) {
              return "Not Mutch ";
            }
          }

          return null;
        }
      },
    );
  }
}
