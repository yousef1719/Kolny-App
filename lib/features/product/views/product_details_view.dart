// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/features/product/widgets/spicy_slider.dart';
import 'package:hungry_app/features/product/widgets/topping_card.dart';
import 'package:hungry_app/shared/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});
  static const double bottomSheetHeightFactor = 0.135;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = 0.7;
  @override
  Widget build(BuildContext context) {
    final bottomSheetHeight =
        screenHeight(context) * ProductDetailsView.bottomSheetHeightFactor;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.secondary,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),

          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal(context, 15),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpicySlider(
                value: value,
                onChanged: (v) => setState(() => value = v),
              ),
              Gap(screenHeight(context) * 0.04),
              CustomText(
                text: 'Toppings',
                fontSize: 18,
                weight: FontWeight.w600,
                color: AppColors.textColor,
              ),
              Gap(screenHeight(context) * 0.02),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizontal(context, 6),
                      ),
                      child: ToppingCard(
                        imagePath: 'assets/test/tomato.png',
                        title: 'Tomato',
                        onAdd: () {
                          print('Tomato added!');
                        },
                      ),
                    );
                  }),
                ),
              ),
              Gap(screenHeight(context) * 0.04),
              CustomText(
                text: 'Side Options',
                fontSize: 18,
                weight: FontWeight.w600,
                color: AppColors.textColor,
              ),
              Gap(screenHeight(context) * 0.02),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizontal(context, 6),
                      ),
                      child: ToppingCard(
                        imagePath: 'assets/test/tomato.png',
                        title: 'Tomato',
                        onAdd: () {
                          print('Tomato added!');
                        },
                      ),
                    );
                  }),
                ),
              ),
              Gap(screenHeight(context) * 0.2),
            ],
          ),
        ),
      ),

      bottomSheet: Container(
        height: bottomSheetHeight,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: 15,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal(context, 20),
            vertical: paddingVertical(context, 20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Total',
                    fontSize: 15,
                    weight: FontWeight.w400,
                    color: AppColors.textColor,
                  ),
                  CustomText(
                    text: '\$15.9',
                    fontSize: 20,
                    weight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ],
              ),
              CustomButton(onTap: () {}, text: 'Add to Cart'),
            ],
          ),
        ),
      ),
    );
  }
}
