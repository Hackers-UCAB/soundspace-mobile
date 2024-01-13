abstract class LocalNotifications {
  Future<bool> authorizationStatus();
  Future<bool> requestPermission();
  Future<void> inicializeLocalNotifications();
  Future<void> setupInteractedMessage();
  void showLocalNotifications(
      {required int id,
      String? title,
      String? body,
      Map<String, dynamic>? data});
  Future<String?> getToken();
  void onForegroundMessage();
}
