abstract class LocationPermission {
  Future<bool> isPermissionGranted();
  Future<bool> requestPermission();
}
