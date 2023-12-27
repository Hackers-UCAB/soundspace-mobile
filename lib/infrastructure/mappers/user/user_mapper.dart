import '../../../domain/user/user.dart';
import '../../../domain/user/valueObjects/birth_day_value_object.dart';
import '../../../domain/user/valueObjects/email_address_value_object.dart';
import '../../../domain/user/valueObjects/gender_value_object.dart';
import '../../../domain/user/valueObjects/id_user_value_object.dart';
import '../../../domain/user/valueObjects/name_value_object.dart';
import '../../../domain/user/valueObjects/phone_value_object.dart';
import '../../../domain/user/valueObjects/user_role_value_object.dart';

class UserMapper {
  static User fromJson(Map<String, dynamic> json) {
    return User(
        id: IdUser(id: json['codigo_usuario']),
        name: UserName(json['nombre']),
        email: EmailAddress(json['correo']),
        phone: PhoneNumber(json['telefono']),
        role: UserRole(role: json['rol']),
        birthdate: BirthDate(json['fecha_nac']),
        gender: Gender(json['genero']));
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
