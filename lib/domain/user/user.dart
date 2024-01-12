// ignore_for_file: prefer_final_fields
import '../../application/services/internet_connection/connection_manager.dart';
import '../services/location_checker.dart';

enum UserRoles { guest, subscriber }

class User {
  String _id;
  String? _name;
  String? _email;
  String? _phone;
  UserRoles _role;
  DateTime? _birthdate;
  String? _token;
  late String _country;

  User({
    required String id,
    String? name,
    String? email,
    String? phone,
    required UserRoles role,
    DateTime? birthdate,
    String? token,
    String? country,
  })  : _id = id,
        _name = name,
        _email = email,
        _phone = phone,
        _role = role,
        _birthdate = birthdate,
        _token = token;

  String get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  UserRoles get role => _role;
  DateTime? get birthdate => _birthdate;
  String? get token => _token;
  String get country => _country;

  Future<void> checkLocation(ILocationChecker locationChecker,
      IConnectionManager connectionManager) async {
    if (_role == UserRoles.subscriber) {
      try {
        await connectionManager
            .checkConnectionStream()
            .firstWhere((isConnected) => isConnected);

        final country = await locationChecker.getCountry();
        if (country != 'Venezuela') {
          _role = UserRoles.guest;
        }
        _country = country;
      } catch (e) {
        rethrow;
      }
    }
  }

  bool validLocation() {
    return _country == 'Venezuela';
  }
}
