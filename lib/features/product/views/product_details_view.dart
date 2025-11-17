// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/features/home/data/models/topping_model.dart';
import 'package:hungry_app/features/home/data/repo/product_repo.dart';
import 'package:hungry_app/features/product/widgets/spicy_slider.dart';
import 'package:hungry_app/features/product/widgets/topping_card.dart';
import 'package:hungry_app/shared/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.productImage});
  static const double bottomSheetHeightFactor = 0.135;
  final String productImage;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = 0.7;
  int? selectedToppingIndex;

  List<ToppingModel>? toppings;
  List<ToppingModel>? options;
  ProductRepo productRepo = ProductRepo();

  Future<void> getToppings() async {
    final res = await productRepo.getToppings();
    if (!mounted) return;
    setState(() {
      toppings = res;
    });
  }

  Future<void> getOptions() async {
    final res = await productRepo.getOptions();
    if (!mounted) return;
    setState(() {
      options = res;
    });
  }

  @override
  void initState() {
    getToppings();
    getOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSheetHeight =
        screenHeight(context) * ProductDetailsView.bottomSheetHeightFactor;
    return Skeletonizer(
      enabled: widget.productImage.isEmpty,
      child: Scaffold(
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
                  img: widget.productImage,
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
                    children: List.generate(toppings?.length ?? 4, (index) {
                      final isSelected = selectedToppingIndex == index;
                      final topping = toppings?[index];
                      if (topping == null) {
                        return CupertinoActivityIndicator();
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: paddingHorizontal(context, 6),
                        ),
                        child: ToppingCard(
                          color: isSelected
                              ? Colors.redAccent.withOpacity(0.3)
                              : AppColors.primary.withOpacity(0.1),
                          imageUrl: topping.image,
                          title: topping.name,
                          onAdd: () =>
                              setState(() => selectedToppingIndex = index),
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
                    children: List.generate(options?.length ?? 4, (index) {
                      final isSelected = selectedToppingIndex == index;
                      final option = options?[index];
                      if (option == null) {
                        return CupertinoActivityIndicator();
                      }
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: paddingHorizontal(context, 6),
                        ),
                        child: ToppingCard(
                          color: isSelected
                              ? Colors.redAccent.withOpacity(0.3)
                              : AppColors.primary.withOpacity(0.1),
                          imageUrl: option.image,
                          title: option.name,
                          onAdd: () =>
                              setState(() => selectedToppingIndex = index),
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
      ),
    );
  }
}
