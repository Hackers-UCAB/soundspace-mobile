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
      'codigo_usuario': user.id,
      'nombre': user.name,
      'correo': user.email,
      'telefono': user.phone,
      'rol': user.role,
      'fecha_nac': user.birthdate,
      'genero': user.gender,
    };
  }
}
