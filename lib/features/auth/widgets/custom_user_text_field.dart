import 'package:flutter/material.dart';

class CustomUserTextField extends StatelessWidget {
  const CustomUserTextField({
    super.key,
    required this.controller,
    required this.label,
    this.textInputType,
    this.prefixIcon,
  });
  final TextEditingController controller;
  final String label;
  final TextInputType? textInputType;
  final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      controller: controller,
      cursorColor: Colors.white,
      cursorHeight: 20,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black54),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
