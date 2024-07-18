class CategoryModel {
  final int? id;
  final String? categoryName;

  const CategoryModel({
    this.id,
    this.categoryName,
  });

  static CategoryModel fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        categoryName: json['categoryName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id?.toString(),
        'categoryName': categoryName,
      };
}
