import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:chat_app/shared_components/util/constants.dart';
import 'package:chat_app/shared_components/widgets/footer_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateAvailableScreen extends StatelessWidget {
  const UpdateAvailableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorPallet.mainGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: ColorPallet.white,
                        size: 80.h,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        Constants.updateAvailable,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorPallet.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        Constants.updateAvailableSubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FooterText(textColor: Colors.white60,),
            ],
          ),
        ),
      ),
    );
  }
}
