import 'package:flutter/material.dart';
import 'package:galal/app_hierarchy/controllers/item_controller.dart';
import 'package:galal/helpers/toast.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../models/item_model.dart';
import '../screens/item_screen.dart';

class CustomItemTile extends GetView<ItemController> {
  const CustomItemTile({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: 140,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          PositionedDirectional(
            bottom: 15,
            start: 10,
            end: 10,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(3, 3), // Shadow position: bottom-right
                  ),
                ],
                borderRadius: BorderRadius.circular(25),
                color: darkColor,
              ),
              child: ListTile(
                onTap: () async {
                  await controller.filterItemView(item.id!);
                  if (controller.filteredItemViewList.isNotEmpty) {
                    Get.to(() => ItemScreen(
                          itemModel: item,
                          propertiesList: controller.filteredItemViewList,
                        ));
                  } else {
                    AppToasts.errorToast('لا يمكن إضافة هذا الصنف حاليًا');
                  }
                },
                leading: const SizedBox(
                  width: 70,
                ),
                title: Text(
                  item.displayName ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: whiteColor),
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        item.displayDescription ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'PlayWrite',
                          color: whiteColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: Column(
                  children: [
                    Obx(() => IconButton(
                        color: controller.isFavorite.value
                            ? accentColor
                            : blackColor,
                        onPressed: controller.toggleFavorite,
                        icon: controller.isFavorite.value
                            ? const Icon(
                                Icons.favorite,
                                color: accentColor,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: accentColor,
                              ))),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            start: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 115,
                  width: 100,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                item.itemImage == null
                    ? Image.asset(
                        'assets/images/drink.webp',
                        height: 140,
                        width: 80,
                      )
                    : Image.network(
                        item.itemImage!,
                        height: 140,
                        width: 80,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
