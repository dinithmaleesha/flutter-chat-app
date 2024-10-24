import 'package:chat_app/shared_components/widgets/custom_button.dart';
import 'package:chat_app/shared_components/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterText extends StatelessWidget {
  final Color textColor;

  const FooterText({super.key, this.textColor = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.h),
      child: InkWell(
        onTap: () => {
          /// TODO: Implement URL launch
        },
        child: Text(
          Constants.footerText,
          style: TextStyle(
            fontSize: 11,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _launchUrl() async {
    final Uri _githubUrl = Uri.parse('https://github.com/dinithmaleesha');
    if(await canLaunchUrl(_githubUrl)){
      await launchUrl(_githubUrl);
    } else {
      throw 'Could not launch $_githubUrl';
    }
  }
}
