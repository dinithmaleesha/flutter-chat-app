import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:chat_app/shared_components/util/constants.dart';
import 'package:chat_app/shared_components/widgets/custom_button.dart';
import 'package:chat_app/shared_components/widgets/footer_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateAvailableScreen extends StatelessWidget {
  final String updateMessage;
  final String updateSubtitle;
  const UpdateAvailableScreen({
    super.key,
    this.updateMessage = Constants.updateAvailable,
    this.updateSubtitle = Constants.updateAvailableSubtitle,
  });

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
                        updateMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorPallet.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        updateSubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white60,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          final Uri _url = Uri.parse('https://play.google.com/store');
                          if (!await launchUrl(_url)) {
                            throw Exception('Could not launch $_url');
                          }
                        },
                        child: Text(
                          Constants.updateNow,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorPallet.mainColor,
                          ),
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
