class CartItemModel {
  final int? id;
  final String? cartID;
  final int? itemID;
  final int? quantity;

  const CartItemModel({
    this.id,
    this.cartID,
    this.itemID,
    this.quantity,
  });

  static CartItemModel fromJson(Map<String, dynamic> json) => CartItemModel(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        cartID: json['cartID'] as String?,
        itemID: json['itemID'] != null
            ? int.tryParse(json['itemID'].toString())
            : null,
        quantity: json['quantity'] != null
            ? int.tryParse(json['quantity'].toString())
            : null,
      );

  Map<String, dynamic> toJson() => {
        'cartID': cartID,
        'itemID': itemID?.toString(),
        'quantity': quantity?.toString(),
      };
}
