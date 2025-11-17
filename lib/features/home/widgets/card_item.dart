// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.text,
    required this.desc,
    required this.rate,
  });

  final String image, text, desc, rate;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 500),
        child: Container(
          height: screenHeight(context) * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
            gradient: LinearGradient(
              colors: [
                AppColors.secondary,
                AppColors.secondary,
                AppColors.secondary,
                Color(0xFFFFCDD2).withOpacity(0.3),
                Color(0xFFFFCDD2).withOpacity(0.3),
                Color(0xFFFFCDD2),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal(context, 14),
              vertical: paddingVertical(context, 10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,

                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          bottom: -8,
                          right: 0,
                          left: 0,
                          child: Image.asset(
                            'assets/icon/shadow.png',
                            color: Colors.black38,
                          ),
                        ),
                        Center(
                          child: Image.network(image, width: 120, height: 135),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(screenHeight(context) * 0.015),
                CustomText(
                  maxLines: 1,
                  text: text,
                  fontSize: 12,
                  weight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
                CustomText(
                  maxLines: 2,
                  text: desc,
                  fontSize: 10,
                  color: AppColors.textColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: '⭐ $rate', fontSize: 12),
                    Icon(
                      CupertinoIcons.heart,
                      color: AppColors.primary,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
