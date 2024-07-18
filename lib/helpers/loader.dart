import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../constants.dart';

Widget loader() => const SpinKitChasingDots(
      color: darkColor,
    );

class Loading {
  static load() => Get.dialog(
        const SpinKitChasingDots(
          color: darkColor,
        ),
        barrierDismissible: false,
      );
  static dispose() => Get.back();
}
