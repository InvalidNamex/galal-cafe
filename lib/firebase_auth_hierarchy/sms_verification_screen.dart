import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../helpers/loader.dart';
import 'auth_controller.dart';

void smsCodeDialog({required String verificationId}) {
  final TextEditingController smsCodeController = TextEditingController();
  Loading.dispose();
  Get.defaultDialog(
    title: 'Enter SMS Code'.tr,
    content: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            autofocus: true,
            controller: smsCodeController,
            keyboardType: TextInputType.number,
            cursorColor: darkColor,
            inputFormatters: [
              LengthLimitingTextInputFormatter(6), // Limit input to 6 digits
              FilteringTextInputFormatter.digitsOnly, // Allow only digits
            ],
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: darkColor),
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              hintText: 'Enter SMS Code'.tr,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: darkColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: darkColor, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the SMS code'.tr;
              }
              if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                return 'Please enter a valid 6-digit SMS code'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            width: Get.width,
            child: ElevatedButton(
              onPressed: () {
                final smsCode = smsCodeController.text;
                if (!RegExp(r'^\d{6}$').hasMatch(smsCode)) {
                  Get.snackbar(
                      'Error', 'Please enter a valid 6-digit SMS code'.tr);
                  return;
                }
                Get.find<AuthController>().signInWithSmsCode(
                  verificationId: verificationId,
                  smsCode: smsCode,
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: whiteColor,
                backgroundColor: darkColor, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // Rounded corners
                ),
              ),
              child: Text(
                'Verify'.tr,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
