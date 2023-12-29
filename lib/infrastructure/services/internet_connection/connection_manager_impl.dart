import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sign_in_bloc/application/services/internet_connection/connection_manager.dart';

class ConnectionManagerImpl extends IConnectionManager {
  final Connectivity connectivity;

  ConnectionManagerImpl({required this.connectivity});

  @override
  Stream<bool> checkConnectionStream() {
    return connectivity.onConnectivityChanged.map((event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        return true;
      } else {
        return false;
      }
    });
  }

  @override
  Future<bool> checkInitialConnection() async {
    final connection = await connectivity.checkConnectivity();
    if (connection == ConnectivityResult.wifi ||
        connection == ConnectivityResult.mobile) {
      return true;
    } else {
      return false;
    }
  }
}
