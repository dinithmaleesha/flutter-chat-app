import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  final IconData icon;
  const ErrorDisplay({super.key, required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: ColorPallet.white,
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: ColorPallet.grayColor,
            ),
            SizedBox(height: 5.h,),
            Text(
              message,
              style: TextStyle(color: ColorPallet.grayColor, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
