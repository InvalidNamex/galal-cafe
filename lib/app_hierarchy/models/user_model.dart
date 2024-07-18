class UserModel {
  final String id;
  final String? userName;
  final String? userPhone;
  final String? userImage;

  const UserModel({
    required this.id,
    this.userName,
    this.userPhone,
    this.userImage,
  });

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        userName: json['userName'] as String?,
        userPhone: json['userPhone'] as String?,
        userImage: json['userImage'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userName': userName,
        'userPhone': userPhone,
        'userImage': userImage,
      };

  UserModel copy({
    required String id,
    String? userName,
    String? userPhone,
    String? userImage,
  }) =>
      UserModel(
        id: id,
        userName: userName ?? this.userName,
        userPhone: userPhone ?? this.userPhone,
        userImage: userImage ?? this.userImage,
      );
}
