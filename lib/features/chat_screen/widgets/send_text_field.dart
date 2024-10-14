import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:chat_app/shared_components/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const SendTextField({
    Key? key,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.left,
      onChanged: onChanged,
      maxLines: null,
      decoration: InputDecoration(
        hintText: Constants.message,
        hintStyle: TextStyle(
          color: ColorPallet.grayColor,
          fontWeight: FontWeight.w400
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: ColorPallet.grayColor, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: ColorPallet.mainColor, width: 2.w),
        ),
        filled: true,
        fillColor: ColorPallet.white,
        contentPadding: EdgeInsets.all(15),
      ),
    );
  }
}
