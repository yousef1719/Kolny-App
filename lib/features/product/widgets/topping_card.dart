import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/shared/custom_text.dart';

class ToppingCard extends StatelessWidget {
  const ToppingCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onAdd,
  });
  final String imagePath;
  final String title;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final double cardWidth = screenWidth(context) * 0.27;
    final double cardHeight = screenHeight(context) * 0.19;
    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: cardHeight * 0.5,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.only(
                left: paddingLeft(context, 10),
                right: paddingRight(context, 10),
                top: paddingTop(context, 30),
                bottom: paddingBottom(context, 8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: title,
                    fontSize: 12,
                    weight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  Gap(screenWidth(context) * 0.01),
                  GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      width: screenWidth(context) * 0.07,
                      height: screenWidth(context) * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: cardHeight * 0.35,
            left: 0,
            right: 0,
            child: Container(
              height: cardHeight * 0.6,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(3, -3),
                  ),
                ],
              ),

              child: Center(
                child: Image.asset(
                  imagePath,
                  width: cardWidth * 0.62,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
