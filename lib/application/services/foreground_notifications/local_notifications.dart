abstract class LocalNotifications {
  Future<bool> authorizationStatus();
  Future<bool> requestPermission();
  Future<void> inicializeLocalNotifications();
  void showLocalNotifications(
      {required int id, String? title, String? body, String? data});
  Future<String?> getToken();
  void onForegroundMessage();
}
