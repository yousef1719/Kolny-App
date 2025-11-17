import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    this.color,
    this.weight,
    this.responsive = true,
    this.textAlign,
    this.maxLines,
  });

  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? weight;
  final bool responsive;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    double finalFontSize = fontSize;

    if (responsive) {
      final double width = MediaQuery.of(context).size.width;
      if (width < 360) {
        finalFontSize = fontSize * 0.9;
      } else if (width > 500) {
        finalFontSize = fontSize * 1.1;
      }
    }

    return Text(
      maxLines: maxLines ?? 3,
      overflow: TextOverflow.ellipsis,
      textScaler: MediaQuery.of(context).textScaler,
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: finalFontSize,
        color: color,
        fontWeight: weight,
      ),
    );
  }
}
