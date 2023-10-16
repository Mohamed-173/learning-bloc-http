import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;

  const SmallText({
    super.key,
    required this.text,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize ?? 10,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
      textAlign: textAlign,
    );
  }
}
