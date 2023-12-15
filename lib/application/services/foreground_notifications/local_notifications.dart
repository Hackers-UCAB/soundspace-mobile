abstract class LocalNotifications {
  Future<void> requestPermissionLocalNotifications();

  Future<void> inicializeLocalNotifications();

  void showLocalNotifications(
      {required int id, String? title, String? body, String? data});
}
