class CartItemPropertiesModel {
  int? id;
  int cartItemId;
  int propertyId;

  CartItemPropertiesModel({
    this.id,
    required this.cartItemId,
    required this.propertyId,
  });

  factory CartItemPropertiesModel.fromJson(Map<String, dynamic> json) {
    return CartItemPropertiesModel(
      id: json['id'],
      cartItemId: json['cartItemID'],
      propertyId: json['propertyID'],
    );
  }

  // Method to convert a CartItemProperties object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'cartItemID': cartItemId,
      'propertyID': propertyId,
    };
  }
}
