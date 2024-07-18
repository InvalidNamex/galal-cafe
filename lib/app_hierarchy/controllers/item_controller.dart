import 'package:galal/app_hierarchy/models/cart_item_model.dart';
import 'package:galal/app_hierarchy/models/cart_item_properties_model.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/item_model.dart';
import '../models/item_view_model.dart';

class ItemController extends GetxController {
  RxList<ItemModel> itemsList = RxList<ItemModel>([]);
  RxMap<int, List<ItemModel>> itemsByCategory = RxMap<int, List<ItemModel>>();
  RxList<ItemViewModel> itemViewList = RxList<ItemViewModel>([]);
  RxList<ItemViewModel> filteredItemViewList = RxList<ItemViewModel>([]);
  RxBool isLottieLoaded = false.obs;
  RxString selectedSize = ''.obs;
  RxString selectedFlavor = ''.obs;
  RxString selectedRoast = ''.obs;
  RxString selectedSugar = ''.obs;
  RxDouble totalPrice = 0.0.obs;
  RxInt totalCount = 1.obs;
  final supabase = Supabase.instance.client;
  RxBool isLoading = false.obs;
  Future<void> _loadLottie() async {
    await Future.delayed(const Duration(microseconds: 10));
    isLottieLoaded.value = true;
  }

  Future<void> initializeData() async {
    isLoading(true);
    await fetchItems();
    await fetchItemView();
    isLoading(false);
  }

  Future<void> fetchItems() async {
    itemsList.clear();
    try {
      final response = await supabase.from('items').select();
      itemsList.value =
          (response as List).map((json) => ItemModel.fromJson(json)).toList();
      _categorizeItems();
    } catch (error) {
      print('Error fetching items: $error');
    }
  }

  Future<void> filterItemView(int itemID) async {
    filteredItemViewList.clear(); // Clear the list before populating
    for (ItemViewModel itemProperty in itemViewList) {
      if (itemProperty.itemId == itemID) {
        filteredItemViewList.add(itemProperty);
      }
    }
    filteredItemViewList
        .sort((item1, item2) => item1.propertyId!.compareTo(item2.propertyId!));

    if (filteredItemViewList.isNotEmpty) {
      selectedSize.value = filteredItemViewList
              .firstWhereOrNull((item) => item.propertyCategoryName == 'Size')
              ?.propertyName ??
          '';
      selectedFlavor.value = filteredItemViewList
              .firstWhereOrNull((item) => item.propertyCategoryName == 'Flavor')
              ?.propertyName ??
          '';
      selectedRoast.value = filteredItemViewList
              .firstWhereOrNull((item) => item.propertyCategoryName == 'Roast')
              ?.propertyName ??
          '';
      selectedSugar.value = filteredItemViewList
              .firstWhereOrNull((item) => item.propertyCategoryName == 'Sugar')
              ?.propertyName ??
          '';
    }
  }

  void _categorizeItems() {
    itemsByCategory.clear();
    for (var item in itemsList) {
      itemsByCategory.putIfAbsent(item.catID!, () => []).add(item);
    }
  }

  List<ItemModel> getItemsByCategory(int categoryId) {
    return itemsByCategory[categoryId] ?? [];
  }

  Future<void> fetchItemView() async {
    itemViewList.clear();
    try {
      final response = await supabase.from('itemsview').select();
      itemViewList.value = (response as List)
          .map((json) => ItemViewModel.fromJson(json))
          .toList();
    } catch (error) {
      print('Error fetching item properties: $error');
    }
  }

  double get calculateTotalPrice {
    double calculatedPrice = 0.0;
    for (var item in filteredItemViewList) {
      if (item.propertyName == selectedSize.value ||
          item.propertyName == selectedFlavor.value ||
          item.propertyName == selectedRoast.value ||
          item.propertyName == selectedSugar.value) {
        calculatedPrice += item.price ?? 0.0;
      }
    }
    return calculatedPrice;
  }

  RxBool isFavorite = false.obs;

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  @override
  void onInit() async {
    super.onInit();
    await initializeData();
    everAll([
      filteredItemViewList,
      selectedSize,
      selectedFlavor,
      selectedRoast,
      selectedSugar
    ], (_) {
      totalPrice.value = calculateTotalPrice;
    });
    _loadLottie();
  }

  @override
  void onClose() {
    selectedSize.value = '';
    selectedFlavor.value = '';
    selectedRoast.value = '';
    selectedSugar.value = '';
    totalPrice.value = 0.0;
    super.onClose();
  }

  Future addItemToCart({required CartItemModel item}) async {
    List _itemCart =
        await supabase.from('cart_item').insert(item.toJson()).select('id');
    int _itemCartID = _itemCart.first['id'];
    List<String> _selectableProperties = [
      selectedSize.value,
      selectedFlavor.value,
      selectedRoast.value,
      selectedSugar.value
    ];
    List<ItemViewModel> _propertiesList = filteredItemViewList
        .where(
            (property) => _selectableProperties.contains(property.propertyName))
        .toList();
    for (ItemViewModel property in _propertiesList) {
      CartItemPropertiesModel cartItemPropertiesModel = CartItemPropertiesModel(
          cartItemId: _itemCartID, propertyId: property.propertyId!);
      await supabase
          .from('cart_item_properties')
          .insert(cartItemPropertiesModel.toJson());
    }
  }
}
