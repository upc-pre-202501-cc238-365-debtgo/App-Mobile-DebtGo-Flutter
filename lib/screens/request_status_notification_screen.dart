import 'package:flutter/material.dart';

class RequestStatusNotificationScreen extends StatelessWidget {
  const RequestStatusNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'Solicitud aceptada',
        'description': 'Tu solicitud fue aceptada por el consultor Carlos Ramírez.',
        'timestamp': '27 jun 2025 • 14:35'
      },
      {
        'title': 'Solicitud en revisión',
        'description': 'El consultor Lucía Torres está revisando tu solicitud.',
        'timestamp': '26 jun 2025 • 10:22'
      },
      {
        'title': 'Solicitud rechazada',
        'description': 'Pedro Gómez ha rechazado tu solicitud. Puedes buscar otro consultor.',
        'timestamp': '25 jun 2025 • 17:48'
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Actualizaciones de Solicitudes')),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['description']!),
            trailing: Text(item['timestamp']!, style: const TextStyle(fontSize: 12)),
          );
        },
      ),
    );
  }
}