import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/shared/custom_text.dart';

class SpicySlider extends StatefulWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged});
  final double value;
  final ValueChanged<double> onChanged;

  @override
  State<SpicySlider> createState() => _SpicySliderState();
}

class _SpicySliderState extends State<SpicySlider> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/detail/sandwatch_details.png',
          height: screenHeight(context) * 0.25,
        ),
        Column(
          children: [
            CustomText(
              text:
                  'Customize Your Burger\nto Your Tastes. Ultimate\nExperience',
              fontSize: 14,
              color: AppColors.textColor,
            ),
            SizedBox(
              width: screenWidth(context) * 0.55,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Slider(
                    min: 0,
                    max: 1,
                    value: widget.value,
                    onChanged: widget.onChanged,
                    activeColor: AppColors.primary,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 20,
                    child: CustomText(text: '🥶', fontSize: 12),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 20,
                    child: CustomText(text: '🌶', fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
