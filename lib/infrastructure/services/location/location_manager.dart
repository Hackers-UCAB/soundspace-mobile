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
  Future<bool> isLocationInVenezuela()async{
   try {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      // verifica si las coordenadas actuales están dentro de los límites de Venezuela
      return _checkIfInsideVenezuela(
          currentPosition.latitude, currentPosition.longitude);
    } catch (e) {
      print("error al obtener la ubicación: $e");
      return false; 
    }
  }
 bool _checkIfInsideVenezuela(double latitude, double longitude) {
    // Lógica para verificar si las coordenadas están dentro de Venezuela
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
