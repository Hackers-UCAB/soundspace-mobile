// ignore_for_file: prefer_final_fields
import '../../application/services/internet_connection/connection_manager.dart';
import '../services/location_checker.dart';

enum UserRoles { guest, subscriber }

class User {
  String id;
  String? name;
  String? email;
  String? phone;
  UserRoles role;
  DateTime? birthdate;
  String? token;
  String? genre;
  late String country;

  User({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.role = UserRoles.guest,
    this.birthdate,
    this.token,
    this.genre,
  });

  Future<void> checkLocation(ILocationChecker locationChecker,
      IConnectionManager connectionManager) async {
    if (role == UserRoles.subscriber) {
      try {
        await connectionManager
            .checkConnectionStream()
            .firstWhere((isConnected) => isConnected);

        final actualCountry = await locationChecker.getCountry();
        if (actualCountry != 'Venezuela') {
          role = UserRoles.guest;
        }
        country = actualCountry;
      } catch (e) {
        rethrow;
      }
    }
  }

  bool validLocation() {
    return country == 'Venezuela';
  }
}
