import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:chetneak_v2/themes/app_theme.dart';

class TitleC1 extends StatelessWidget {
  final String name;
  const TitleC1({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name.tr,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        letterSpacing: 0.27,
        color: AppTheme.darkText,
      ),
    );
  }
}
