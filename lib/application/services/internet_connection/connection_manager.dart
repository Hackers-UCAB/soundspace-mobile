abstract class IConnectionManager {
  Stream<bool> checkConnectionStream();
  Future<bool> checkInitialConnection();
}
