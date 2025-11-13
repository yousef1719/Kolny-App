// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/features/auth/data/user_model.dart';
import 'package:hungry_app/shared/custom_text.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key, this.userModel});
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    final image = userModel?.image;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/logo/logo.svg',
              color: AppColors.primary,
              height: screenHeight(context) * 0.050,
            ),
            Gap(screenHeight(context) * 0.005),
            CustomText(
              text: 'Hello, Youssef Magdy',
              fontSize: 14,
              weight: FontWeight.w400,
              color: Color(0XFF212121),
            ),
          ],
        ),

        CircleAvatar(
          radius: screenHeight(context) * 0.035,
          backgroundColor: AppColors.primary,
          backgroundImage: (image != null && image.isNotEmpty)
              ? NetworkImage(image)
              : null,
          child: (image == null || image.isEmpty)
              ? Icon(CupertinoIcons.person, color: Colors.white)
              : null,
        ),
      ],
    );
  }
}
