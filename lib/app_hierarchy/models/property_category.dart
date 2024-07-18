class PropertyCategoryModel {
  final int? id;
  final String? categoryName;

  const PropertyCategoryModel({
    this.id,
    this.categoryName,
  });

  static PropertyCategoryModel fromJson(Map<String, dynamic> json) =>
      PropertyCategoryModel(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        categoryName: json['categoryName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id?.toString(),
        'categoryName': categoryName,
      };
}
