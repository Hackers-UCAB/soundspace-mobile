import 'package:geolocator/geolocator.dart';
import 'package:sign_in_bloc/application/services/location/location_manager.dart';

class LocationManagerImpl implements LocationManager {
  @override
  Future<bool> isLocationServiceEnabled() =>
      Geolocator.isLocationServiceEnabled();

  @override
  Stream<bool> locationStatusStream() => Geolocator.getServiceStatusStream()
      .map((event) => event == ServiceStatus.enabled);
}
