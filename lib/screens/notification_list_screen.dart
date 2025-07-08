import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    final notifications = lang == 'es'
        ? [
      '📬 Recordatorio: Revisa tus deudas hoy.',
      '📢 Nuevo mensaje de tu asesor.',
      '🔔 Actualización de tu plan de suscripción.',
    ]
        : [
      '📬 Reminder: Check your debts today.',
      '📢 New message from your advisor.',
      '🔔 Subscription plan update.',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Notificaciones' : 'Notifications'),
      ),
      body: notifications.isEmpty
          ? Center(
        child: Text(
          lang == 'es'
              ? 'No tienes notificaciones por ahora.'
              : 'You have no notifications for now.',
          style: const TextStyle(color: Colors.grey),
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notifications_active,
                color: Colors.indigo),
            title: Text(notifications[index]),
          );
        },
      ),
    );
  }
}