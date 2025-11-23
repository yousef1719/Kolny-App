import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.height,
    this.color,
    this.radius,
    this.widget,
    this.gab,
  });
  final String text;
  final Function()? onTap;
  final double? width;
  final double? height;
  final Color? color;
  final double? radius;
  final Widget? widget;
  final double? gab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? screenHeight(context) * 0.07,
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal(context, 20),
          vertical: paddingVertical(context, 15),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 10),
          color: color ?? AppColors.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: text,
              fontSize: 14,
              color: Colors.white,
              weight: FontWeight.w500,
            ),
            Gap(gab ?? 0),
            widget ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
