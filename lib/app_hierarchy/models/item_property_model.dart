class ItemPropertyModel {
  final int? id;
  final int? itemID;
  final String? propertyName;
  final int? propertyCategory;
  const ItemPropertyModel({
    this.id,
    this.itemID,
    this.propertyName,
    this.propertyCategory,
  });

  static ItemPropertyModel fromJson(Map<String, dynamic> json) =>
      ItemPropertyModel(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        itemID: json['itemID'] != null
            ? int.tryParse(json['itemID'].toString())
            : null,
        propertyName: json['propertyName'] as String?,
        propertyCategory: json['propertyCategory'] != null
            ? int.tryParse(json['propertyCategory'].toString())
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id?.toString(),
        'itemID': itemID?.toString(),
        'propertyName': propertyName,
        'propertyCategory': propertyCategory?.toString(),
      };
}
