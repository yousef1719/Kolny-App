// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/features/checkout/widgets/order_details_widget.dart';
import 'package:hungry_app/shared/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});
  static const double bottomSheetHeightFactor = 0.135;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedMethod = 'cash';

  @override
  Widget build(BuildContext context) {
    final bottomSheetHeight =
        screenHeight(context) * CheckoutView.bottomSheetHeightFactor;
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
              CustomText(
                text: 'Order summary',
                fontSize: 20,
                weight: FontWeight.w500,
              ),
              OrderDetailsWidget(
                order: '16.48',
                taxes: '3',
                fees: '1',
                total: '20.48',
              ),
              Gap(screenHeight(context) * 0.06),
              CustomText(
                text: 'Payment methods',
                fontSize: 20,
                weight: FontWeight.w500,
              ),
              Gap(screenHeight(context) * 0.02),

              /// cash
              ListTile(
                onTap: () => setState(() => selectedMethod = 'cash'),
                contentPadding: EdgeInsets.symmetric(
                  vertical: paddingVertical(context, 10),
                  horizontal: paddingHorizontal(context, 10),
                ),
                tileColor: Color(0XFF3C2F2F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: Image.asset('assets/icon/cash.png'),
                title: CustomText(
                  text: 'Cash on Delivery',
                  fontSize: 16,
                  color: Colors.white,
                ),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  onChanged: (value) => setState(() => selectedMethod = value!),
                  value: 'cash',
                  groupValue: selectedMethod,
                ),
              ),
              Gap(screenHeight(context) * 0.015),

              /// debit
              ListTile(
                onTap: () => setState(() => selectedMethod = 'visa'),
                contentPadding: EdgeInsets.symmetric(
                  vertical: paddingVertical(context, 2),
                  horizontal: paddingHorizontal(context, 10),
                ),
                tileColor: Colors.blue.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: Image.asset(
                  'assets/icon/visa_icon.png',
                  color: Colors.white,
                ),
                title: CustomText(
                  text: 'Debit Card',
                  fontSize: 16,
                  color: Colors.white,
                ),
                subtitle: CustomText(
                  text: '**** **** **** 1234',
                  fontSize: 14,
                  color: Colors.white,
                ),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  onChanged: (value) => setState(() => selectedMethod = value!),
                  value: 'visa',
                  groupValue: selectedMethod,
                ),
              ),
              Gap(screenHeight(context) * 0.001),
              Row(
                children: [
                  Checkbox(
                    activeColor: Color(0XFFEF2A39),
                    value: true,
                    onChanged: (value) {},
                  ),
                  CustomText(
                    text: 'Save card details for future payments',
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                ],
              ),
              Gap(screenHeight(context) * 0.2),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
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
        height: bottomSheetHeight,
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
                  ),
                  CustomText(
                    text: '\$15.9',
                    fontSize: 20,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
              CustomButton(
                text: 'Pay now',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: paddingVertical(context, 150),
                            horizontal: paddingHorizontal(context, 5),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(paddingAll(context, 20)),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade800,
                                  blurRadius: 15,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: AppColors.primary,
                                  child: Icon(
                                    CupertinoIcons.check_mark,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                Gap(screenHeight(context) * 0.04),
                                CustomText(
                                  text: 'Success!',
                                  color: AppColors.primary,
                                  fontSize: 20,
                                  weight: FontWeight.bold,
                                ),
                                Gap(screenHeight(context) * 0.02),
                                CustomText(
                                  textAlign: TextAlign.center,
                                  text:
                                      'Your payment was successful.\nreceipt for this purchase has\nbeen sent to your email.',
                                  color: Colors.grey.shade800,

                                  fontSize: 12,
                                ),
                                Gap(screenHeight(context) * 0.04),
                                CustomButton(
                                  width: screenWidth(context) * 0.5,
                                  onTap: () => Navigator.pop(context),
                                  text: 'close',
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
