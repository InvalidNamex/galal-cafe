import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app_hierarchy/controllers/cart_controller.dart';
import '/constants.dart';
import '../../localization_hierarchy/lanugages.dart';
import '../controllers/home_controller.dart';

class CheckoutScreen extends GetView<CartController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: darkColor.withOpacity(0.6),
          onPressed: () async {
            final HomeController homeController = Get.find<HomeController>();
            String _userID = homeController.user.id;
            await controller.placeOrder(userID: _userID);
          },
          label: Row(
            children: [
              Text('Place your order'.tr),
              const SizedBox(
                width: 5,
              ),
              const Icon(Icons.shopping_basket_outlined)
            ],
          )),
      appBar: AppBar(
        title: Text('Shopping Cart'.tr),
        centerTitle: true,
        backgroundColor: darkColor,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back.webp'),
                fit: BoxFit.fill)),
        child: Obx(
          () => controller.cartItemViewList.isEmpty
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_basket_outlined,
                        color: accentColor,
                        size: 60,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Your cart is empty'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          color: darkColor,
                          fontFamily:
                              Languages.isArabic ? 'Cairo' : 'Playwrite',
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.groupedCartItems.length,
                          itemBuilder: (context, index) {
                            var item = controller.groupedCartItems[index];
                            var propertyNames =
                                item.propertyName?.split(', ') ?? [];
                            return Card(
                              color: whiteColor.withOpacity(0.9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        item.itemName,
                                        style: TextStyle(
                                          color: darkColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Languages.isArabic
                                              ? 'Cairo'
                                              : 'Playwrite',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          ...propertyNames.map((propertyName) {
                                            return Text(
                                              '$propertyName, ',
                                              style: TextStyle(
                                                color: darkColor,
                                                fontSize: 12,
                                                fontFamily: Languages.isArabic
                                                    ? 'Cairo'
                                                    : 'Playwrite',
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            int _id = controller
                                                .groupedCartItems[index]
                                                .cartItemId;
                                            await controller.deleteCartItem(
                                                cartItemID: _id);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: darkColor),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.delete_forever_outlined,
                                                  size: 25,
                                                  color: whiteColor,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Delete'.tr,
                                                    style: const TextStyle(
                                                        color: whiteColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.remove_circle_outline),
                                              onPressed: () async {
                                                int _id = controller
                                                    .groupedCartItems[index]
                                                    .cartItemId;
                                                int _quantity = controller
                                                        .groupedCartItems[index]
                                                        .quantity -
                                                    1;
                                                await controller
                                                    .decreaseQuantity(
                                                  cartItemID: _id,
                                                  quantity: _quantity,
                                                );
                                              },
                                            ),
                                            Text(item.quantity.toString()),
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.add_circle_outline),
                                              onPressed: () async {
                                                int _id = controller
                                                    .groupedCartItems[index]
                                                    .cartItemId;
                                                int _quantity = controller
                                                        .groupedCartItems[index]
                                                        .quantity +
                                                    1;
                                                await controller
                                                    .increaseQuantity(
                                                  cartItemID: _id,
                                                  quantity: _quantity,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${(item.propertyPrice! * item.quantity).toStringAsFixed(2)} L.E',
                                          style: TextStyle(
                                            color: darkColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: Languages.isArabic
                                                ? 'Cairo'
                                                : 'Playwrite',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
