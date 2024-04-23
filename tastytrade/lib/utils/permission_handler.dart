import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<void> requestNotificationPermission() async {
    Map<Permission, PermissionStatus> statusNotification = await [
      Permission.notification,
    ].request();
    print('Notification status${statusNotification[Permission.notification]}');
  }
}
