import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController {
  bool get isArabic => Get.locale?.languageCode == 'ar';

  var textDirection = TextDirection.ltr.obs;

  Future<void> saveLocale(String language) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'language';
    await prefs.setString(key, language);
  }

  Future<void> readLocale() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'language';
    String? value = prefs.getString(key);
    if (value == 'ar') {
      Get.updateLocale(const Locale('ar', 'EG'));
      textDirection.value = TextDirection.rtl;
    } else if (value == 'en') {
      Get.updateLocale(const Locale('en', 'US'));
      textDirection.value = TextDirection.ltr;
    } else {
      Get.updateLocale(Get.deviceLocale!);
      textDirection.value = Get.locale!.languageCode == 'ar'
          ? TextDirection.rtl
          : TextDirection.ltr;
    }
  }

  @override
  void onReady() async {
    await readLocale();
    super.onReady();
  }
}
