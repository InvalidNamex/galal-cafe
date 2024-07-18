import 'package:galal/app_hierarchy/controllers/cart_controller.dart';
import 'package:galal/app_hierarchy/controllers/item_controller.dart';
import 'package:get/get.dart';

import 'controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ItemController());
  }
}

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CartController());
  }
}
