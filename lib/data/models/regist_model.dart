import '../../domain/entities/user_entity.dart';

class RegistModel extends UserEntity {
  final String? password;
  final String? confirmPassword;

  RegistModel(
      {this.password,
      this.confirmPassword,
      super.email,
      super.firstName,
      super.lastName,
      super.profileImage});

  factory RegistModel.fromJson(Map<String, dynamic> json) {
    return RegistModel(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      password: json['password'],
      confirmPassword: json['password_confirm'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['password'] = password;
    data['password_confirm'] = confirmPassword;
    return data;
  }
}
