abstract class LocationManager {
  Stream<bool> locationStatusStream();
  Future<bool> isLocationServiceEnabled();
  Future<bool> checkPermission();
  Future<void> requestPermission();
  Future<bool> isLocationInVenezuela(); //TODO: Implementar esto
}
