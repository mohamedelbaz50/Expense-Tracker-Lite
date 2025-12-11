import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final int maxLines;
  final Widget? prefixIcon;
  final bool isReadOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.obscureText,
    this.suffixIcon,
    this.maxLines = 1,
    this.prefixIcon,
    this.isReadOnly = false,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      validator: validator,
      onTap: onTap,
      maxLines: maxLines,
      controller: controller,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
        fillColor: Colors.grey[100],
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(width: 0, color: Colors.transparent),
        ),
      ),
    );
  }
}
