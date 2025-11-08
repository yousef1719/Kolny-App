import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/size_config.dart';
import 'package:hungry_app/shared/custom_text.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.order,
    required this.taxes,
    required this.fees,
    required this.total,
  });
  final String order, taxes, fees, total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(screenHeight(context) * 0.01),
        checkoutWidget('Order', order, false, false),
        Gap(screenHeight(context) * 0.01),
        checkoutWidget('Taxes', taxes, false, false),
        Gap(screenHeight(context) * 0.01),
        checkoutWidget('Delivery fees', fees, false, false),
        Gap(screenHeight(context) * 0.01),
        Divider(),
        Gap(screenHeight(context) * 0.01),
        checkoutWidget('Total', total, true, false),
        Gap(screenHeight(context) * 0.01),
        checkoutWidget('Estimated delivery time:', '15 - 30 mins', true, true),
      ],
    );
  }
}

Widget checkoutWidget(title, price, isBold, isSmall) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: title,
        fontSize: isSmall ? 12 : 15,
        weight: isBold ? FontWeight.bold : FontWeight.w400,
        color: isBold ? Colors.black : Colors.grey.shade600,
      ),
      CustomText(
        text: '\$$price',
        fontSize: isSmall ? 12 : 15,
        weight: isBold ? FontWeight.bold : FontWeight.w400,
        color: isBold ? Colors.black : Colors.grey.shade600,
      ),
    ],
  );
}
