import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galal/helpers/toast.dart';
import 'package:get/get.dart';
import 'package:typewritertext/typewritertext.dart';

import '/firebase_auth_hierarchy/auth_controller.dart';
import '../constants.dart';
import '../helpers/loader.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneForm = GlobalKey<FormState>();
    TextEditingController phoneNumber = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: phoneForm,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TypeWriter.text(
                    "Galal Coffee",
                    maintainSize: false,
                    style: const TextStyle(
                      fontFamily: 'Playwrite',
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    duration: const Duration(milliseconds: 50),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/images/splash.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Playwrite',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    controller: phoneNumber,
                    keyboardType: TextInputType.phone,
                    cursorColor: darkColor,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          11), // Limit input to 11 digits
                      FilteringTextInputFormatter
                          .digitsOnly, // Allow only digits
                    ],
                    decoration: InputDecoration(
                      labelText: 'Phone Number'.tr, // Add your label here
                      labelStyle: const TextStyle(
                          color: darkColor), // Optional: Customize label style
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: darkColor),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: darkColor, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: darkColor, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number'.tr;
                      }
                      if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                        return 'Please enter a valid 11-digit phone number'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: Get.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (phoneForm.currentState?.validate() ?? false) {
                          Loading.load();
                          await controller.phoneAuth(phone: phoneNumber.text);
                        } else {
                          AppToasts.errorToast(
                              'The provided phone number is not valid.'.tr);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: whiteColor,
                        backgroundColor: darkColor, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(25), // Rounded corners
                        ),
                      ),
                      child: Text(
                        'Verify'.tr,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
