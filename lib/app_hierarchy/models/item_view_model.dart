import '../../localization_hierarchy/lanugages.dart';

class ItemViewModel {
  final int? itemId;
  final String? itemName;
  final String? itemNameAR;
  final String? itemImage;
  final String? propertyCategoryName;
  final int? propertyId;
  final String? propertyName;
  final String? propertyNameAR;
  final double? price;

  const ItemViewModel({
    this.itemId,
    this.itemName,
    this.itemNameAR,
    this.itemImage,
    this.propertyCategoryName,
    this.propertyId,
    this.propertyName,
    this.propertyNameAR,
    this.price,
  });

  static ItemViewModel fromJson(Map<String, dynamic> json) => ItemViewModel(
        itemId: json['item_id'] as int?,
        itemName: json['item_name'] as String?,
        itemNameAR: json['item_name_ar'] as String?,
        itemImage: json['item_image'] as String?,
        propertyCategoryName: json['property_category_name'] as String?,
        propertyId: json['property_id'] as int?,
        propertyName: json['property_name'] as String?,
        propertyNameAR: json['property_name_ar'] as String?,
        price: (json['price'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'item_id': itemId,
        'item_name': itemName,
        'item_name_ar': itemNameAR,
        'item_image': itemImage,
        'property_category_name': propertyCategoryName,
        'property_id': propertyId,
        'property_name': propertyName,
        'property_name_ar': propertyNameAR,
        'price': price,
      };

  ItemViewModel copy({
    int? itemId,
    String? itemName,
    String? itemNameAR,
    String? itemImage,
    String? itemDescription,
    String? itemDescriptionAR,
    String? propertyCategoryName,
    int? propertyId,
    String? propertyName,
    String? propertyNameAR,
    double? price,
  }) =>
      ItemViewModel(
        itemId: itemId ?? this.itemId,
        itemName: itemName ?? this.itemName,
        itemNameAR: itemNameAR ?? this.itemNameAR,
        itemImage: itemImage ?? this.itemImage,
        propertyCategoryName: propertyCategoryName ?? this.propertyCategoryName,
        propertyId: propertyId ?? this.propertyId,
        propertyName: propertyName ?? this.propertyName,
        propertyNameAR: propertyNameAR ?? this.propertyNameAR,
        price: price ?? this.price,
      );
  String? get displayName =>
      Languages.isArabic ? itemNameAR ?? itemName : itemName ?? itemNameAR;
  String? get displayPropertyName => Languages.isArabic
      ? propertyNameAR ?? propertyName
      : propertyName ?? propertyNameAR;
}
