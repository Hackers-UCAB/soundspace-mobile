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
        id: IdUser(id: json['id']),
        name: UserName(json['name']),
        email: EmailAddress(json['email']),
        gender: Gender(json['genre']));
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
