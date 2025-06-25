import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../main.dart';
import '../routes/app_routes.dart';

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidInit);

    final status = await Permission.notification.request();
    if (!status.isGranted) {
      print("Permiso de notificaciones no concedido");
      return;
    }

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("🔔 TAP en notificación: payload = ${response.payload}");
        if (response.payload == 'open_notifications') {
          navigatorKey.currentState?.pushNamed(AppRoutes.notifications);
        }
      },
      // Aún puedes declarar esto aunque no navegues aquí
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(NotificationResponse response) {
    // No navegar aquí: solo útil si quieres guardar algo en SharedPreferences, por ejemplo
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
