import 'dart:ffi';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialize native Ios Notifications
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    tz.initializeTimeZones();
  }

  void showNotificationAndroid(String title, String value) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'Channel Name',
            channelDescription: 'Channel Description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    int notification_id = 1;
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        notification_id, title, value, notificationDetails,
        payload: 'Not present');
  }

  Future<int> showTimedNotification(
      String title, String description, int value) async {
    // notification_id = get the id of the largest notification_id and add 1
    int notification_id = await flutterLocalNotificationsPlugin
        .pendingNotificationRequests()
        .then((value) => value.length + 1);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        notification_id,
        title,
        description,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: value)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    return notification_id;
  }

  // update time of a notification
  // void updateTimedNotification(int notificationId, String title, String description, int value) async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       notificationId,
  //       title,
  //       description,
  //       tz.TZDateTime.now(tz.local).add(Duration(seconds: value)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               'your channel id', 'your channel name',
  //               channelDescription: 'your channel description')),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }
  void deleteNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }
}
