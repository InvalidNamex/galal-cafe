import 'package:flutter/material.dart';
import 'package:galal/app_hierarchy/controllers/item_controller.dart';
import 'package:galal/constants.dart';
import 'package:get/get.dart';

import '../../helpers/loader.dart';
import '../controllers/home_controller.dart';
import 'custom_item_tile_widget.dart';

class CustomTabBar extends GetView<HomeController> {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final itemController = Get.find<ItemController>();
    return Obx(() {
      if (controller.categoryList.isEmpty || itemController.isLoading.value) {
        return Center(child: loader());
      }

      return DefaultTabController(
        length: controller.categoryList.length,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              indicatorColor: darkColor,
              tabs: controller.categoryList.map((category) {
                return Tab(
                  child: Text(
                    category.categoryName?.tr ?? '',
                    style: const TextStyle(
                        color: darkColor,
                        fontFamily: 'Playwrite',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: TabBarView(
                children: controller.categoryList.map((category) {
                  return Obx(() {
                    final items =
                        itemController.getItemsByCategory(category.id!);

                    if (items.isEmpty) {
                      return const Center(child: Text('No items found'));
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) => CustomItemTile(
                            item: items[index],
                          ),
                        ),
                      );
                    }
                  });
                }).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
