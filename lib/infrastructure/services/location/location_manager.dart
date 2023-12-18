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

  //TODO: Hacer la verificacion de que este en Venezuela
}
