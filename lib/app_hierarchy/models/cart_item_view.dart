class CartItemViewModel {
  final int cartItemId;
  final int itemID;
  final String cartID;
  final String itemName;
  final int quantity;
  final int? propertyId;
  final String? propertyName;
  final double? propertyPrice;

  CartItemViewModel({
    required this.cartItemId,
    required this.itemName,
    required this.quantity,
    required this.itemID,
    required this.cartID,
    this.propertyId,
    this.propertyName,
    this.propertyPrice,
  });

  factory CartItemViewModel.fromJson(Map<String, dynamic> json) {
    return CartItemViewModel(
      cartItemId: json['cart_item_id'],
      itemID: json['item_id'],
      cartID: json['cart_id'],
      itemName: json['item_name'],
      quantity: json['quantity'],
      propertyId: json['property_id'],
      propertyName: json['property_name'],
      propertyPrice: json['property_price']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_item_id': cartItemId,
      'item_id': itemID,
      'cart_id': cartID,
      'item_name': itemName,
      'quantity': quantity,
      'property_id': propertyId,
      'property_name': propertyName,
      'property_price': propertyPrice,
    };
  }
}
