import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  final String name;

  const ChatAppBar({required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            color: ColorPallet.white,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
