import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  ChatBubble({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  final Gradient mainGradient = LinearGradient(
    colors: [ColorPallet.mainColor, ColorPallet.secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: isMe ? mainGradient : null,
        color: isMe ? null : ColorPallet.gray,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: isMe ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
