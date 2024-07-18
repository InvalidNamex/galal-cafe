import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galal/constants.dart';
import 'package:galal/localization_hierarchy/localization_controller.dart';
import 'package:get/get.dart';

import '../../localization_hierarchy/update_locale_button.dart';
import '../controllers/home_controller.dart';
import '../custom_widgets/custom_tab_bar.dart';
import '../utilities/get_time_of_day.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationController = Get.find<LocalizationController>();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Drawer openEndDrawer() {
      return Drawer(
        child: ListView(
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  showLocaleDialog();
                },
                title: Text('Language'.tr),
                trailing: const Icon(
                  Icons.language_outlined,
                  color: darkColor,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Log out'.tr),
                trailing: const Icon(
                  Icons.exit_to_app_rounded,
                  color: darkColor,
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.offAllNamed('/login-screen');
                },
              ),
            )
          ],
        ),
      );
    }

    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Obx(() {
          return DefaultTabController(
            length: controller.categoryList.length,
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.toNamed('/checkout-screen');
                },
                backgroundColor: darkColor,
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: whiteColor,
                ),
              ),
              key: _scaffoldKey,
              endDrawer: openEndDrawer(),
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.search)),
                        IconButton(
                            onPressed: () {
                              _scaffoldKey.currentState?.openEndDrawer();
                            },
                            icon: const Icon(Icons.menu)),
                      ],
                    ),
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..scale(
                          localizationController.isArabic ? -1.0 : 1.0, 1.0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/intro-back.webp'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..scale(localizationController.isArabic ? -1.0 : 1.0,
                              1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                getTimeOfDay(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                localizationController.isArabic
                                    ? '''جاهز لمشروب من اختيارك وممكن كمان نحلي؟'''
                                    : 'Ready for a hot beverage and some relaxation.',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: CustomTabBar()),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
