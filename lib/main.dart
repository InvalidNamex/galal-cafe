import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '/app_hierarchy/screens/home_screen.dart';
import '/firebase_auth_hierarchy/login_screen.dart';
import '/firebase_options.dart';
import 'app_hierarchy/bindings.dart';
import 'app_hierarchy/screens/checkout_screen.dart';
import 'firebase_auth_hierarchy/bindings.dart';
import 'firebase_auth_hierarchy/splash_screen.dart';
import 'localization_hierarchy/lanugages.dart';
import 'localization_hierarchy/localization_controller.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Supabase.initialize(
        url: dotenv.env['SUPABASE_URL']!,
        anonKey: dotenv.env['SUPABASE_ANNON_KEY']!);
  } catch (e) {
    Logger().e(e.toString());
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LocalizationController localizationController =
        Get.put(LocalizationController());
    return GetMaterialApp(
      locale: Get.deviceLocale,
      translations: Languages(),
      fallbackLocale: const Locale('en', 'US'),
      title: 'Galal',
      initialRoute: '/',
      enableLog: true,
      theme: ThemeData(useMaterial3: false, fontFamily: 'Cairo'),
      logWriterCallback: (text, {isError = false}) {
        if (isError) {
          Logger().e(text);
        } else {
          Logger().i(text);
        }
      },
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: AuthBinding(),
      getPages: [
        GetPage(
            name: '/',
            page: () => const SplashScreen(),
            binding: AuthBinding(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 200)),
        GetPage(
            name: '/login-screen',
            page: () => const LoginScreen(),
            binding: AuthBinding(),
            transition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 200)),
        GetPage(
            name: '/home-screen',
            page: () => const HomeScreen(),
            binding: HomeBinding(),
            transition: Transition.circularReveal,
            transitionDuration: const Duration(milliseconds: 200)),
        GetPage(
            name: '/checkout-screen',
            page: () => const CheckoutScreen(),
            binding: CartBinding(),
            transition: Transition.zoom,
            transitionDuration: const Duration(milliseconds: 400)),
      ],
      builder: (context, child) {
        return Obx(() {
          return Directionality(
            textDirection: localizationController.textDirection.value,
            child: child!,
          );
        });
      },
    );
  }
}

//todo: لما نضيف نفس الصنف مرتين العدد بس اللي يزيد
//todo: كل التعديلات على سلة المشتريات تتم داخليا وفقط لما تتنفذ تتم على القاعدة
//todo: استخدم الكاش مع الصور عشان تقلل وقت التحميل
