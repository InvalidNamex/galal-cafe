import 'package:galal/app_hierarchy/controllers/home_controller.dart';
import 'package:galal/app_hierarchy/models/purchase_history_model.dart';
import 'package:galal/helpers/toast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/cart_item_view.dart';
import '../models/purchase_history_item_model.dart';

class CartController extends GetxController {
  RxList<CartItemViewModel> cartItemViewList = <CartItemViewModel>[].obs;
  final supabase = Supabase.instance.client;

  Future<void> fetchCartItems() async {
    cartItemViewList.clear();
    final supabase = Supabase.instance.client;
    final homeController = Get.find<HomeController>();
    try {
      final response = await supabase
          .from('cart_item_view')
          .select()
          .eq('cart_id', homeController.user.id);
      cartItemViewList.value = (response as List)
          .map((json) => CartItemViewModel.fromJson(json))
          .toList();
    } catch (error) {
      Logger().e(error);
      AppToasts.errorToast('Failed to fetch cart items.');
    }
  }

  List<CartItemViewModel> get groupedCartItems {
    var grouped = <int, CartItemViewModel>{};
    var propertyNames = <int, List<String>>{};

    for (var item in cartItemViewList) {
      if (grouped.containsKey(item.cartItemId)) {
        var existingItem = grouped[item.cartItemId]!;
        grouped[item.cartItemId] = CartItemViewModel(
          cartItemId: existingItem.cartItemId,
          itemID: existingItem.itemID,
          cartID: existingItem.cartID,
          itemName: existingItem.itemName,
          quantity: item.quantity, // Use only item.quantity
          propertyId: existingItem.propertyId,
          propertyName: existingItem.propertyName,
          propertyPrice:
              (existingItem.propertyPrice ?? 0) + (item.propertyPrice ?? 0),
        );
        propertyNames[item.cartItemId]!.add(item.propertyName ?? '');
      } else {
        grouped[item.cartItemId] = item;
        propertyNames[item.cartItemId] = [item.propertyName ?? ''];
      }
    }

    return grouped.values.map((item) {
      var names = propertyNames[item.cartItemId] ?? [];
      return CartItemViewModel(
        cartItemId: item.cartItemId,
        itemID: item.itemID,
        cartID: item.cartID,
        itemName: item.itemName,
        quantity: item.quantity,
        propertyId: item.propertyId,
        propertyName: names.join(', '),
        propertyPrice: item.propertyPrice,
      );
    }).toList();
  }

  Future decreaseQuantity(
      {required int cartItemID, required int quantity}) async {
    if (quantity >= 1) {
      try {
        await supabase
            .from('cart_item')
            .update({'quantity': quantity}).eq('id', cartItemID);
        await fetchCartItems();
      } finally {
        AppToasts.errorToast('Try again later'.tr);
      }
    } else {}
  }

  Future increaseQuantity(
      {required int cartItemID, required int quantity}) async {
    try {
      await supabase
          .from('cart_item')
          .update({'quantity': quantity}).eq('id', cartItemID);
      await fetchCartItems();
    } finally {
      AppToasts.errorToast('Try again later'.tr);
    }
  }

  Future deleteCartItem({required int cartItemID}) async {
    try {
      await supabase.from('cart_item').delete().eq('id', cartItemID);
      await fetchCartItems();
    } finally {
      AppToasts.errorToast('Try again later'.tr);
    }
  }

  Future placeOrder({required String userID}) async {
    try {
      PurchaseHistoryModel _purchaseHistory =
          PurchaseHistoryModel(userID: userID, purchaseDate: DateTime.now());
      var _x = await supabase
          .from('purchase_history')
          .insert(_purchaseHistory.toJson())
          .select('id');
      int _id = _x.first['id'];
      // add items to that order
      List<PurchaseHistoryItemModel> _orderItemsList = [];
      groupedCartItems.forEach((cartItem) => _orderItemsList.add(
          PurchaseHistoryItemModel(
              purchaseHistoryID: _id,
              quantity: cartItem.quantity,
              price: cartItem.propertyPrice,
              itemName: cartItem.itemName,
              optionName: cartItem.propertyName)));
      final List<Map<String, dynamic>> jsonList =
          _orderItemsList.map((item) => item.toJson()).toList();
      var _post = await supabase
          .from('purchase_history_item')
          .insert(jsonList)
          .select('id')
          .whenComplete(() async {
        await supabase
            .from('cart_item')
            .delete()
            .eq('cartID', userID)
            .whenComplete(() async {
          //todo: navigate to track order and history
          await fetchCartItems();
        });
      });
      AppToasts.successToast(_post.first['id'].toString());
    } catch (e) {
      if (e.toString() == 'Bad state: No element') {
        AppToasts.errorToast('Empty Cart'.tr);
      } else {
        AppToasts.errorToast('Try again later'.tr);
        Logger().e(e.toString());
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }
}
