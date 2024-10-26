import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final DateTime time;
  final bool isMe;

  ChatBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String formattedTime = DateFormat('HH:mm').format(time);

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
        minWidth: MediaQuery.of(context).size.width * 0.2,
      ),
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      decoration: BoxDecoration(
        gradient: isMe ? ColorPallet.mainGradient : null,
        color: isMe ? null : ColorPallet.gray,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14.sp,
              color: isMe ? Colors.white : Colors.black,
            ),
          ),
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: 10.sp,
              color: isMe ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
