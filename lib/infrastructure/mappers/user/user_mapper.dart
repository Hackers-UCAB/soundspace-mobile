import '../../../domain/user/user.dart';

class UserMapper {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      birthdate:
          json['birthdate'] != null ? DateTime.parse(json['birthdate']) : null,
      phone: json['phone'],
      token: json['token'],
      genre: json['gender'],
      role:
          json['role'] == 'subscriber' ? UserRoles.subscriber : UserRoles.guest,
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'codigo_usuario': user.id,
      'nombre': user.name,
      'correo': user.email,
      'telefono': user.phone,
      'rol': user.role,
      'fecha_nac': user.birthdate,
    };
  }
}
