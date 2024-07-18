class PurchaseHistoryModel {
  final int? id;
  final String? userID;
  final DateTime? purchaseDate;
  final double? totalAmount;

  const PurchaseHistoryModel({
    this.id,
    this.userID,
    this.purchaseDate,
    this.totalAmount,
  });

  static PurchaseHistoryModel fromJson(Map<String, dynamic> json) =>
      PurchaseHistoryModel(
          id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
          userID: json['userID'],
          purchaseDate: json['purchaseDate'],
          totalAmount: json['totalAmount']);

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'purchaseDate': purchaseDate?.toIso8601String(),
        'totalAmount': totalAmount,
      };
}
