import '../../localization_hierarchy/lanugages.dart';

class ItemModel {
  final int? id;
  final String? itemName;
  final String? itemNameAR;
  final String? itemImage;
  final int? catID;
  final String? itemDescription;
  final String? itemDescriptionAR;

  const ItemModel({
    this.id,
    this.itemName,
    this.itemNameAR,
    this.itemImage,
    this.catID,
    this.itemDescription,
    this.itemDescriptionAR,
  });

  static ItemModel fromJson(Map<String, dynamic> json) => ItemModel(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        itemName: json['itemName'] as String?,
        itemNameAR: json['itemNameAR'] as String?,
        itemImage: json['itemImage'] as String?,
        catID: json['catID'] != null
            ? int.tryParse(json['catID'].toString())
            : null,
        itemDescription: json['itemDescription'] as String?,
        itemDescriptionAR: json['itemDescriptionAR'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id?.toString(),
        'itemName': itemName,
        'itemNameAR': itemNameAR,
        'itemImage': itemImage,
        'catID': catID?.toString(),
        'itemDescription': itemDescription,
        'itemDescriptionAR': itemDescriptionAR,
      };
  String? get displayName =>
      Languages.isArabic ? itemNameAR ?? itemName : itemName ?? itemNameAR;
  String? get displayDescription => Languages.isArabic
      ? itemDescriptionAR ?? itemDescription
      : itemDescription ?? itemDescriptionAR;
}
