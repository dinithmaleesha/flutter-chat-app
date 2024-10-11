import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:flutter/material.dart';

class NoUserAvailable extends StatelessWidget {
  final String text;
  final IconData icon;

  const NoUserAvailable({
    super.key,
    this.text = 'No User Available',
    this.icon = Icons.person_off,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: ColorPallet.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: ColorPallet.mainColor,
            ),
            const SizedBox(height: 10.0),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18.0,
                color: ColorPallet.mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
