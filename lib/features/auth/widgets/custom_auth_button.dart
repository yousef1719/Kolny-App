import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    this.onTap,
    required this.text,
    this.color,
    this.textColor,
    this.width,
  });
  final Function()? onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? screenWidth(context),
        padding: EdgeInsets.all(paddingWidth(context, 16)),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: CustomText(
            text: text,
            fontSize: 14,
            color: textColor ?? AppColors.primary,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
