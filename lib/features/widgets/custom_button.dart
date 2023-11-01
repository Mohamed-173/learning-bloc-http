import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPress;
  final String text;
  final double? height;

  final double? width;
  final Color? color;
  final Color? fontColor;
  CustomButton({
    Key? key,
    this.onPress,
    required this.text,
    this.height,
    this.width,
    this.color,
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 300,
      height: height ?? 50,
      child: MaterialButton(
        disabledColor: color ?? Colors.grey,
        onPressed: onPress,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.5),
        ),
        color: color ?? Colors.white,
        child: Text(
          text,
          style: TextStyle(
            color: fontColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
