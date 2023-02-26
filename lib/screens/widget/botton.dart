import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chetneak_v2/themes/app_theme.dart';

class Botton extends StatelessWidget {
  const Botton({Key? key, required this.text, required this.onPress})
      : super(key: key);
  final onPress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        minimumSize: const Size(1000, 48),
        backgroundColor: AppTheme.primary,
      ),
      onPressed: onPress,
      child: Text(
        text.tr,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          letterSpacing: 0.0,
          color: AppTheme.nearlyWhite,
        ),
      ),
    );
  }
}
