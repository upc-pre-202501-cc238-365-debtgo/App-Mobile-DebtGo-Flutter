import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../routes/app_routes.dart';
import '../services/language_service.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidInit);

    final status = await Permission.notification.request();
    if (!status.isGranted) {
      print("❌ Notification permission not granted");
      return;
    }

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        print("🔔 TAP en notificación: payload = ${response.payload}");
        if (response.payload == 'open_notifications') {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('navigateToNotifications', true);
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(NotificationResponse response) {
    print("🕗 [Background] TAP en notificación con payload: ${response.payload}");
  }

  static Future<void> showScheduledNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasNotification', true);

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'debtgo_channel',
          'DebtGo Notificaciones',
          channelDescription: 'Canal para notificaciones programadas',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: 'open_notifications',
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}