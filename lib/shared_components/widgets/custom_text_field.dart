import 'package:chat_app/main.dart';
import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final Function(String)? onChanged;
  final String? errorText;
  final double borderRadius;

  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText = 'Enter Name',
    this.fillColor,
    this.hintStyle,
    this.onChanged,
    this.borderRadius = 40,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.left,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: errorText,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: ColorPallet.red, width: 2.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: ColorPallet.mainColor, width: 2.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: ColorPallet.grayColor, width: 1.w),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: ColorPallet.red, width: 2.w),
          ),
          filled: true,
          fillColor: fillColor ?? ColorPallet.white,
          hintStyle: hintStyle ?? TextStyle(
            fontSize: 16,
            color: ColorPallet.grayColor,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        ),
      ),
    );
  }
}
