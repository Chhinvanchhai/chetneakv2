import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chetneak_v2/screens/widget/h3.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({Key? key}) : super(key: key);
  void changeLocale() {
    var locale = Get.locale.toString();
    GetStorage box = GetStorage();
    if (locale == 'kh_KH') {
      Get.updateLocale(const Locale('en', 'US'));
      box.write('langCode', 'en');
      box.write('countryCode', 'US');
    } else {
      Get.updateLocale(const Locale('kh', 'KH'));
      box.write('langCode', 'kh');
      box.write('countryCode', 'KH');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.6),
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity(vertical: 0),
        title: H3(title: 'language'),
        onTap: () => changeLanuge(context),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }

  changeLanuge(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.only(bottom: 18.0, left: 16),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Image.asset(
                      'assets/images/en.png',
                      height: 20,
                    ),
                    title: H3(title: 'English'),
                    onTap: () {
                      changeLocale();
                      Navigator.pop(context);
                    }),
                ListTile(
                  leading: Image.asset(
                    'assets/images/kh.jpg',
                    height: 20,
                  ),
                  title: H3(title: 'Khmer'),
                  onTap: () {
                    changeLocale();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}
