class PriceListDetailModel {
  final int? id;
  final int? itemID;
  final int? priceListID;
  final int? itemProperty;
  final double? price;

  const PriceListDetailModel({
    this.id,
    this.itemID,
    this.priceListID,
    this.itemProperty,
    this.price,
  });

  static PriceListDetailModel fromJson(Map<String, dynamic> json) =>
      PriceListDetailModel(
        id: json['id'] as int?,
        itemID: json['itemID'] as int?,
        priceListID: json['priceListID'] as int?,
        itemProperty: json['itemProperty'] as int?,
        price: json['price'] as double?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'itemID': itemID,
        'priceListID': priceListID,
        'itemProperty': itemProperty,
        'price': price,
      };
}
