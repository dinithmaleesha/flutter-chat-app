import 'package:chat_app/features/register_screen/views/custom_button.dart';
import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/features/chat_screen/views/chat_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatUserCard extends StatelessWidget {
  final String name;
  final String deviceId;
  final String currentUserId;
  final bool isOnline;

  const ChatUserCard({
    Key? key,
    required this.name,
    required this.deviceId,
    required this.currentUserId,
    required this.isOnline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              senderId: currentUserId,
              receiverId: deviceId,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r)
          ),
          color: ColorPallet.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: CircleAvatar(
                    backgroundColor: ColorPallet.white,
                    child: Icon(Icons.person, color: ColorPallet.mainColor, size: 36,),
                  ),
                ),
                SizedBox(width: 15.w,),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                Spacer(),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isOnline ? Colors.green : Colors.red,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
