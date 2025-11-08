// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    this.onAdd,
    this.onMinus,
    this.onRemove,
    required this.number,
  });
  final int number;
  final String image, text, desc;
  final Function()? onAdd, onMinus, onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [AppColors.secondary, Color(0xFFFFCDD2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context) * 0.05,
            vertical: screenHeight(context) * 0.02,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: screenHeight(context) * -0.008,
                        right: 0,
                        left: 0,
                        child: Image.asset(
                          'assets/icon/shadow.png',
                          width: screenWidth(context) * 0.30,
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          image,
                          width: screenWidth(context) * 0.2,
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    text: text,
                    fontSize: 14,
                    weight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                  CustomText(
                    text: desc,
                    fontSize: 12,
                    color: AppColors.textColor,
                  ),
                ],
              ),

              Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onAdd,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            CupertinoIcons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      Gap(screenWidth(context) * 0.03),
                      CustomText(
                        text: number.toString(),
                        fontSize: 20,
                        weight: FontWeight.w500,
                        color: AppColors.textColor,
                      ),
                      Gap(screenWidth(context) * 0.03),
                      GestureDetector(
                        onTap: onMinus,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            CupertinoIcons.minus,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(screenHeight(context) * 0.02),
                  GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizontal(context, 20),
                        vertical: paddingVertical(context, 10),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: CustomText(
                          text: 'Remove',
                          fontSize: 14,
                          color: Colors.white,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ),
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
