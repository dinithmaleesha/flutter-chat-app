import 'package:chat_app/features/chat_screen/views/chat_screen.dart';
import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:chat_app/shared_components/util/constants.dart';
import 'package:chat_app/shared_components/widgets/footer_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnderMaintenanceScreen extends StatelessWidget {
  const UnderMaintenanceScreen({super.key});

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
                        Icons.build,
                        color: ColorPallet.white,
                        size: 80.h,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        Constants.underMaintenanceTitle,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorPallet.white,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        Constants.underMaintenanceSubtitle,
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
