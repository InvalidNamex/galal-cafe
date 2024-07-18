import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '/app_hierarchy/controllers/home_controller.dart';
import '/app_hierarchy/controllers/item_controller.dart';
import '/app_hierarchy/models/cart_item_model.dart';
import '/app_hierarchy/models/item_model.dart';
import '/app_hierarchy/models/item_view_model.dart';
import '/constants.dart';
import '/helpers/loader.dart';
import '/localization_hierarchy/localization_controller.dart';
import '../custom_widgets/item_count_widget.dart';

class ItemScreen extends GetView<ItemController> {
  final ItemModel itemModel;
  final List<ItemViewModel> propertiesList;

  const ItemScreen(
      {super.key, required this.itemModel, required this.propertiesList});

  @override
  Widget build(BuildContext context) {
    final localizationController = Get.find<LocalizationController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addToCart(
          itemModel: itemModel,
          propertiesList: propertiesList,
          price: controller.totalPrice.value,
        ),
        backgroundColor: darkColor,
        icon: const Icon(
          Icons.shopping_cart_checkout,
          color: Colors.white,
        ),
        label: Obx(() => Text(controller.totalPrice.value.toStringAsFixed(2))),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Drink Image
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..scale(
                            localizationController.isArabic ? -1.0 : 1.0, 1.0),
                      child: Container(
                        height: 280,
                        width: Get.width,
                        alignment: Alignment.topRight,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/drink-back.webp'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    itemModel.itemImage != null
                        ? Image.network(
                            itemModel.itemImage!,
                            width: 200,
                            height: 200,
                          )
                        : Image.asset(
                            'assets/images/drink.webp',
                            width: 200,
                            height: 200,
                          ),
                  ],
                ),
                const SizedBox(height: 16),
                // Drink Name
                Expanded(
                  child: controller.filteredItemViewList.isEmpty
                      ? Center(child: loader())
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(end: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itemModel.displayName ?? '',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Drink Description
                                Text(
                                  itemModel.displayDescription ?? '',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 16),
                                // Size Options
                                buildSizeWidget(),
                                // Flavor Options
                                buildFlavorWidget(),
                                // Roast Options
                                buildRoastWidget(),
                                // Sugar Options
                                buildSugarWidget()
                              ],
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
          PositionedDirectional(
            start: 10,
            top: 25,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: whiteColor,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: darkColor,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: accentColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Obx buildSizeWidget() {
    return Obx(() {
      var sizeItems = controller.filteredItemViewList
          .where((item) => item.propertyCategoryName == 'Size')
          .toList();
      if (sizeItems.isNotEmpty) {
        return SizedBox(
          height: 150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Size'.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var sizeItem = sizeItems[index];
                    return _buildSizeOption(
                      image: 'assets/images/drink-size.webp',
                      size: sizeItem.propertyName ?? '',
                      propertyName: sizeItem.displayPropertyName ?? '',
                      price: sizeItem.price.toString(),
                      height: _getHeightForIndex(index),
                      width: _getWidthForIndex(index),
                      selectedSize: controller.selectedSize,
                    );
                  },
                  itemCount: sizeItems.length,
                ),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Obx buildFlavorWidget() {
    return Obx(() {
      var flavorsList = controller.filteredItemViewList
          .where((item) => item.propertyCategoryName == 'Flavor')
          .toList();
      if (flavorsList.isNotEmpty) {
        return SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  'Flavor'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: controller.selectedFlavor.value.isEmpty
                      ? null
                      : controller.selectedFlavor.value,
                  hint: Text('Select a flavor'.tr),
                  items: flavorsList.map((ItemViewModel flavor) {
                    return DropdownMenuItem<String>(
                      value: flavor.propertyName,
                      child: Text(flavor.displayPropertyName ?? ''),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedFlavor.value = newValue;
                    }
                  },
                ),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Obx buildRoastWidget() {
    return Obx(() {
      var roastList = controller.filteredItemViewList
          .where((item) => item.propertyCategoryName == 'Roast')
          .toList();
      if (roastList.isNotEmpty) {
        return SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  'Roast'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: controller.selectedRoast.value.isEmpty
                      ? null
                      : controller.selectedRoast.value,
                  hint: Text('Select a roast'.tr),
                  items: roastList.map((ItemViewModel flavor) {
                    return DropdownMenuItem<String>(
                      value: flavor.propertyName,
                      child: Text(flavor.displayPropertyName ?? ''),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedRoast.value = newValue;
                    }
                  },
                ),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Obx buildSugarWidget() {
    return Obx(() {
      var sugarList = controller.filteredItemViewList
          .where((item) => item.propertyCategoryName == 'Sugar')
          .toList();
      if (sugarList.isNotEmpty) {
        return SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  'Sugar'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: controller.selectedSugar.value.isEmpty
                      ? null
                      : controller.selectedSugar.value,
                  hint: Text('Select Sugar'.tr),
                  items: sugarList.map((ItemViewModel flavor) {
                    return DropdownMenuItem<String>(
                      value: flavor.propertyName,
                      child: Text(flavor.displayPropertyName ?? ''),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      controller.selectedSugar.value = newValue;
                    }
                  },
                ),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Widget _buildSizeOption({
    required String image,
    required String size,
    required String propertyName,
    required double height,
    required double width,
    required String price,
    required RxString selectedSize,
  }) {
    return Column(
      children: [
        Text(propertyName),
        const Spacer(),
        itemModel.itemImage != null && itemModel.itemImage!.isNotEmpty
            ? Image.network(itemModel.itemImage!,
                fit: BoxFit.fill, height: height, width: width)
            : Image.asset(image,
                fit: BoxFit.fill, height: height, width: width),
        Row(
          children: [
            Obx(() => Radio(
                  value: size,
                  activeColor: darkColor,
                  groupValue: selectedSize.value,
                  onChanged: (value) {
                    selectedSize.value = value as String;
                  },
                )),
            Text('$price L.E'),
          ],
        ),
      ],
    );
  }

  void _addToCart(
      {required ItemModel itemModel,
      required List<ItemViewModel> propertiesList,
      required double price}) {
    Get.defaultDialog(
      title: itemModel.displayName ?? '',
      titleStyle:
          const TextStyle(color: darkColor, fontWeight: FontWeight.bold),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              if (controller.isLottieLoaded.value) {
                return Lottie.asset('assets/lottie_load.json',
                    width: 75, height: 100, fit: BoxFit.contain);
              } else {
                return loader();
              }
            }),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      (controller.totalPrice.value *
                              controller.totalCount.value)
                          .toStringAsFixed(2),
                      style: const TextStyle(
                          fontFamily: 'Playwrite',
                          color: darkColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  itemCountWidget(controller.totalCount)
                ]),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                final homeController = Get.find<HomeController>();
                CartItemModel _cartItem = CartItemModel(
                    cartID: homeController.user.id,
                    itemID: itemModel.id,
                    quantity: controller.totalCount.value);
                await controller.addItemToCart(item: _cartItem);
                controller.totalCount(1);
                Get.back();
                Get.snackbar('item added'.tr, 'Ready to checkout?'.tr,
                    backgroundColor: darkColor,
                    colorText: whiteColor,
                    duration: const Duration(seconds: 2),
                    snackPosition: SnackPosition.BOTTOM,
                    icon: const Icon(
                      Icons.shopping_cart_checkout,
                      color: accentColor,
                    ), onTap: (v) {
                  Get.toNamed('/checkout-screen');
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 5, left: 5),
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: darkColor,
                          border: Border.all(color: darkColor),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: Text(
                        'add to cart'.tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Playwrite',
                            color: accentColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: darkColor),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30))),
                    child: const Icon(
                      Icons.add_shopping_cart,
                      color: darkColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double _getHeightForIndex(int index) {
    switch (index) {
      case 0:
        return 40;
      case 1:
        return 50;
      default:
        return 60;
    }
  }

  double _getWidthForIndex(int index) {
    switch (index) {
      case 0:
        return 30;
      case 1:
        return 35;
      default:
        return 40;
    }
  }
}
