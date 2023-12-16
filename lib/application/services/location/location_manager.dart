abstract class LocationManager {
  Stream<bool> locationStatusStream();
  Future<bool> isLocationServiceEnabled();
}
