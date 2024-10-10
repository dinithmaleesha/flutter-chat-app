import 'package:chat_app/features/register_screen/views/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.h),
      child: InkWell(
        onTap: () => {
          /// TODO: Implement URL launch
        },
        child: Text(
          'Developed with ❤️ by Dinith Maleesha',
          style: TextStyle(
            fontSize: 11,
            color: Colors.black54,
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
