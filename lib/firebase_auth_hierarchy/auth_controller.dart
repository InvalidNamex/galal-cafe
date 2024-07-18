import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as s;

import '/firebase_auth_hierarchy/sms_verification_screen.dart';
import '../app_hierarchy/models/user_model.dart';
import '../helpers/toast.dart';

class AuthController extends GetxController {
  RxString smsCode = ''.obs;

  void checkAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Get.offNamed('/login-screen');
      } else {
        final supabase = s.Supabase.instance.client;
        await supabase
            .from('users')
            .upsert(UserModel(id: user.uid).toJson(), onConflict: 'id');

        Get.offNamed('/home-screen');
      }
    });
  }

  Future phoneAuth({required String phone}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: '+2${phone}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        Get.off('/home-screen');
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          AppToasts.errorToast('The provided phone number is not valid.'.tr);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        smsCodeDialog(verificationId: verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        AppToasts.errorToast('Auto-resolution timed out...'.tr);
      },
    );
  }

  Future signInWithSmsCode(
      {required String verificationId, required String smsCode}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      await auth.signInWithCredential(credential);
      Get.offNamed('/home-screen');
    } catch (e) {
      AppToasts.errorToast('Failed to sign in: $e'.tr);
    }
  }

  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }
}
