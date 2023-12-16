import '../../../application/services/location/location_permission_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionImpl extends LocationPermission {
  final PermissionWithService _permissions;

  LocationPermissionImpl({required PermissionWithService permissions})
      : _permissions = permissions;

  @override
  Future<bool> isPermissionGranted() async => await _permissions.isGranted;

  @override
  Future<bool> requestPermission() async {
    final status = await _permissions.request();

    switch (status) {
      case PermissionStatus.granted:
        return true;

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.provisional:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        return false;
    }
  }
}
