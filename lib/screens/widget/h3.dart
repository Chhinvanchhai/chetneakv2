import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chetneak_v2/themes/app_theme.dart';

class H3 extends StatelessWidget {
  const H3({Key? key, this.size = 16, this.color, required this.title})
      : super(key: key);
  final Color? color;
  final String title;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      title.tr,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: size,
        letterSpacing: 0.27,
      ),
    );
  }
}
