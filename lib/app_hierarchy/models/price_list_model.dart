class PriceListModel {
  final int? id;
  final String? name;
  final bool? isActive;

  const PriceListModel({
    this.id,
    this.name,
    this.isActive,
  });

  static PriceListModel fromJson(Map<String, dynamic> json) => PriceListModel(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        name: json['name'] as String?,
        isActive: json['isActive'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'isActive': isActive,
      };
}
