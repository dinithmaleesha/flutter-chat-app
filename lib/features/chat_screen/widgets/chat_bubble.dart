import 'package:chat_app/features/chat_screen/views/chat_screen.dart';
import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  ChatBubble({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: isMe ? ColorPallet.mainGradient : null,
        color: isMe ? null : ColorPallet.gray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 14.sp,
          color: isMe ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
