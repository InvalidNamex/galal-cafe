import 'package:get/get.dart';

String getTimeOfDay() {
  final now = DateTime.now();
  final hour = now.hour;

  if (hour >= 0 && hour < 12) {
    return 'Good morning'.tr;
  } else if (hour >= 12 && hour < 17) {
    return 'Good afternoon'.tr;
  } else if (hour >= 17 && hour < 21) {
    return 'Good evening'.tr;
  } else {
    return 'Good night'.tr;
  }
}
