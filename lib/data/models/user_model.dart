import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(token: json['token']);
  }
}
