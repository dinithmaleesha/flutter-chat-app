import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onMorePressed;

  CustomAppBar({
    required this.title,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: ColorPallet.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: ColorPallet.white,),
          onPressed: onMorePressed,
        ),
      ],
    );
  }
}
