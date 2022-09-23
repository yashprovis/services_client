import 'package:flutter/material.dart';

class ScText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final double? spacing;
  final double? height;

  const ScText(this.text,
      {Key? key,
      this.size,
      this.weight,
      this.color,
      this.align,
      this.maxLines,
      this.spacing,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          height: height,
          letterSpacing: spacing ?? 1.5,
          color: color ?? Colors.black,
          fontWeight: weight ?? FontWeight.w400,
          fontSize: size ?? 16),
    );
  }
}
