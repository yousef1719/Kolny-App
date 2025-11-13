import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/shared/custom_text.dart';

class FoodCategory extends StatefulWidget {
  const FoodCategory({
    super.key,
    required this.selectedIndex,
    required this.category,
  });
  final int selectedIndex;
  final List category;

  @override
  State<FoodCategory> createState() => _FoodCategoryState();
}

class _FoodCategoryState extends State<FoodCategory> {
  late int selectedIndex;
  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.hardEdge,
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: paddingVertical(context, 8)),
        child: Row(
          children: List.generate(widget.category.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: paddingHorizontal(context, 8)),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? AppColors.primary
                      : Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black12),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: paddingVertical(context, 15),
                  horizontal: paddingHorizontal(context, 25),
                ),
                child: CustomText(
                  text: widget.category[index],
                  fontSize: 12,
                  weight: FontWeight.w500,
                  color: selectedIndex == index
                      ? Colors.white
                      : AppColors.textColor,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
