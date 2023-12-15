abstract class LocationManager {
  Future<bool> checkGpsStatus();
  Future<bool> isLocationServiceEnabled();
}
