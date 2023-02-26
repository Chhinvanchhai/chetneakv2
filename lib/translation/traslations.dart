import 'package:get/get.dart';
import './en.dart';
import './kh.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'kh': kh,
      };
}
