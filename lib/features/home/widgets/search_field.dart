// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0).withOpacity(0.35),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.black12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: TextField(
            style: const TextStyle(color: Colors.black87),
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              filled: false,
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: AppColors.textColor,
                size: 22,
              ),
              hintText: 'Search',
              hintStyle: const TextStyle(color: AppColors.textColor),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ),
    );
  }
}
