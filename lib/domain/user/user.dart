import 'valueObjects/birth_day_value_object.dart';
import 'valueObjects/email_address_value_object.dart';
import 'valueObjects/id_user_value_object.dart';
import 'valueObjects/name_value_object.dart';
import 'valueObjects/phone_value_object.dart';
import 'valueObjects/user_role_value_object.dart';

class User {
  final IdUser? _id;
  final UserName? _name;
  final EmailAddress? _email;
  final PhoneNumber? _phone;
  final UserRole? _role;
  final BirthDate? _birthdate;
  final String? _appToken;
  final String? _notificationsToken;

  User(
      {IdUser? id,
      UserName? name,
      EmailAddress? email,
      PhoneNumber? phone,
      UserRole? role,
      BirthDate? birthdate,
      String? appToken,
      String? notificationsToken})
      : _id = id,
        _name = name,
        _email = email,
        _phone = phone,
        _role = role,
        _birthdate = birthdate,
        _appToken = appToken,
        _notificationsToken = notificationsToken;

  IdUser? get id => _id;
  UserName? get name => _name;
  EmailAddress? get email => _email;
  PhoneNumber? get phone => _phone;
  UserRole? get role => _role;
  BirthDate? get birthdate => _birthdate;
  String? get appToken => _appToken;
  String? get notificationsToken => _notificationsToken;
}
