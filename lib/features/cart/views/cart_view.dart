import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/features/cart/widgets/cart_item.dart';
import 'package:hungry_app/features/checkout/views/checkout_view.dart';
import 'package:hungry_app/shared/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});
  static const double bottomSheetHeightFactor = 0.135;

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final int intemCount = 20;
  late List<int> quatities;
  @override
  void initState() {
    super.initState();
    quatities = List.generate(intemCount, (index) => 1);
  }

  void onAdd(int index) {
    setState(() {
      quatities[index]++;
    });
  }

  void onMinus(int index) {
    setState(() {
      if (quatities[index] > 1) {
        quatities[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.secondary,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                intemCount,
                (index) => CartItem(
                  image: 'assets/test/image 6.png',
                  text: 'Hamburger',
                  desc: 'Veggie Burger',
                  number: quatities[index],
                  onAdd: () => onAdd(index),
                  onMinus: () => onMinus(index),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Total',
                        fontSize: 15,
                        weight: FontWeight.w400,
                      ),
                      CustomText(
                        text: '\$15.9',
                        fontSize: 20,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckoutView(),
                        ),
                      );
                    },
                    text: 'Checkout',
                  ),
                ],
              ),

              SizedBox(height: 100), // مسافة إضافية عشان الـ bottom navbar
            ],
          ),
        ),
      ),
    );
  }
}





















      // bottomSheet: Container(
      //   decoration: BoxDecoration(
      //     color: AppColors.secondary,
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(30),
      //       topRight: Radius.circular(30),
      //     ),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.shade800,
      //         blurRadius: 15,
      //         offset: Offset(0, 0),
      //       ),
      //     ],
      //   ),

      //   height: bottomSheetHeight,
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(
      //       horizontal: paddingHorizontal(context, 20),
      //       vertical: paddingVertical(context, 20),
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             CustomText(
      //               text: 'Total',
      //               fontSize: 15,
      //               weight: FontWeight.w400,
      //             ),
      //             CustomText(
      //               text: '\$15.9',
      //               fontSize: 20,
      //               weight: FontWeight.w600,
      //             ),
      //           ],
      //         ),
      //         CustomButton(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const CheckoutView(),
      //               ),
      //             );
      //           },
      //           text: 'Checkout',
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
