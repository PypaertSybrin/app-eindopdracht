import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<void> requestNotificationPermission() async {
    await [
      Permission.notification,
    ].request();
  }
}
