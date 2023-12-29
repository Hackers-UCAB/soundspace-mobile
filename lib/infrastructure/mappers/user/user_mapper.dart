import '../../../domain/user/user.dart';

class UserMapper {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['token'],
      phone: json['phone'],
      role:
          json['role'] == 'subscriber' ? UserRoles.subscriber : UserRoles.guest,
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'number': user.phone,
      'codigo_usuario': user.id,
    };
  }
}
