import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({super.email, super.firstName, super.lastName, super.profileImage});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        profileImage: json['profile_image']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['profile_image'] = profileImage;
    return data;
  }
}
