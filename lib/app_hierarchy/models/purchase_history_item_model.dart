class PurchaseHistoryItemModel {
  final int? id;
  final int? purchaseHistoryID;
  final String? itemName;
  final String? optionName;
  final int? quantity;
  final double? price;

  const PurchaseHistoryItemModel({
    this.id,
    this.purchaseHistoryID,
    this.quantity,
    this.price,
    this.itemName,
    this.optionName,
  });

  static PurchaseHistoryItemModel fromJson(Map<String, dynamic> json) =>
      PurchaseHistoryItemModel(
        id: json['id'],
        itemName: json['itemName'],
        purchaseHistoryID: json['purchaseHistoryID'],
        quantity: json['quantity'],
        price: json['price'],
        optionName: json['optionName'],
      );

  Map<String, dynamic> toJson() => {
        'purchaseHistoryID': purchaseHistoryID,
        'itemName': itemName,
        'optionName': optionName,
        'quantity': quantity,
        'price': price,
      };
}
