// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/shared/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.secondary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.04),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 120, top: 20),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              color: AppColors.secondary,
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
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingHorizontal(context, 20),
                    vertical: paddingVertical(context, 20),
                  ),
                  child: Column(
                    children: [
                      Row(
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
                                      'assets/test/image 6.png',
                                      width: screenWidth(context) * 0.2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Hamburger',
                                fontSize: 14,
                                weight: FontWeight.bold,
                                color: AppColors.textColor,
                              ),
                              CustomText(
                                text: 'Qty : X3',
                                fontSize: 12,
                                color: AppColors.textColor,
                              ),
                              CustomText(
                                text: 'price : 20\$',
                                fontSize: 12,
                                color: AppColors.textColor,
                              ),
                            ],
                          ),
                        ],
                      ),

                      Gap(screenHeight(context) * 0.02),
                      CustomButton(
                        text: 'Order Again',
                        width: screenWidth(context),
                        color: AppColors.primary.withOpacity(0.8),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
