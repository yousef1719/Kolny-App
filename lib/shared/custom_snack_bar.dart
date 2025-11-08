import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/shared/custom_text.dart';

SnackBar customSnackBar(errorMsg) {
  return SnackBar(
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.only(bottom: 30, left: 15, right: 15),
    behavior: SnackBarBehavior.floating,
    clipBehavior: Clip.none,
    elevation: 10,
    backgroundColor: const Color.fromARGB(255, 133, 20, 20),
    content: Row(
      children: [
        Icon(CupertinoIcons.info, color: Colors.white),
        Gap(20),
        Expanded(
          child: CustomText(
            text: errorMsg,
            fontSize: 12,
            color: Colors.white,
            weight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
