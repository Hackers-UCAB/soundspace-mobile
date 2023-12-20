import '../../../domain/user/user.dart';
import '../../../domain/user/valueObjects/id_user_value_object.dart';

class UserMapper {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: IdUser(id: '456'), //TODO: Cambiar por el codigo que tenga el back
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'number': user.phone,
      'codigo_usuario': user.id,
    };
  }
}
