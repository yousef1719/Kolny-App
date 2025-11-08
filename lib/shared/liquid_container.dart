// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';

Widget glassContainer({required Widget child}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: BackdropFilter(
      enabled: true,
      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.2),
              AppColors.primary.withOpacity(0.2),
              AppColors.primary.withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1.2, color: Colors.black.withOpacity(0.05)),
        ),
        child: child,
      ),
    ),
  );
}
