import 'package:geolocator/geolocator.dart';
import 'package:sign_in_bloc/application/services/location/location_manager.dart';

class LocationManagerImpl implements LocationManager {
  @override
  Future<bool> isLocationServiceEnabled() =>
      Geolocator.isLocationServiceEnabled();

  @override
  Stream<bool> locationStatusStream() => Geolocator.getServiceStatusStream()
      .map((event) => event == ServiceStatus.enabled);

  @override
  Future<bool> checkPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<void> requestPermission() async {
    await Geolocator.requestPermission();
  }

  @override
  Future<bool> isLocationVenezuela() async {
    final position = await Geolocator.getCurrentPosition();
    return _checkIfInsideVenezuela(position.latitude, position.longitude);

    // return Stream.periodic(const Duration(minutes: 1))
    //     .asyncMap((_) => Geolocator.getCurrentPosition())
    //     .map((Position position) {
    //   return _checkIfInsideVenezuela(position.latitude, position.longitude);
    // });
  }

  bool _checkIfInsideVenezuela(double latitude, double longitude) {
    //  verificar si las coordenadas están dentro de Venezuela
    const double minLatitude = 0.66;
    const double maxLatitude = 12.2;
    const double minLongitude = -73.4;
    const double maxLongitude = -59.8;

    if (latitude >= minLatitude &&
        latitude <= maxLatitude &&
        longitude >= minLongitude &&
        longitude <= maxLongitude) {
      return true; // dentro de Venezuela
    } else {
      return false; // fuera de Venezuela
    }
  }
}
