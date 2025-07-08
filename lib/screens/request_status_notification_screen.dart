import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class RequestStatusNotificationScreen extends StatelessWidget {
  const RequestStatusNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    final List<Map<String, Map<String, String>>> notifications = [
      {
        'title': {
          'es': 'Solicitud aceptada',
          'en': 'Request Accepted',
        },
        'description': {
          'es': 'Tu solicitud fue aceptada por el consultor Carlos Ramírez.',
          'en': 'Your request was accepted by consultant Carlos Ramírez.',
        },
        'timestamp': {
          'es': '27 jun 2025 • 14:35',
          'en': 'Jun 27, 2025 • 2:35 PM',
        },
      },
      {
        'title': {
          'es': 'Solicitud en revisión',
          'en': 'Request Under Review',
        },
        'description': {
          'es': 'El consultor Lucía Torres está revisando tu solicitud.',
          'en': 'Consultant Lucía Torres is reviewing your request.',
        },
        'timestamp': {
          'es': '26 jun 2025 • 10:22',
          'en': 'Jun 26, 2025 • 10:22 AM',
        },
      },
      {
        'title': {
          'es': 'Solicitud rechazada',
          'en': 'Request Rejected',
        },
        'description': {
          'es': 'Pedro Gómez ha rechazado tu solicitud. Puedes buscar otro consultor.',
          'en': 'Pedro Gómez has rejected your request. You may look for another consultant.',
        },
        'timestamp': {
          'es': '25 jun 2025 • 17:48',
          'en': 'Jun 25, 2025 • 5:48 PM',
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang == 'es' ? 'Actualizaciones de Solicitudes' : 'Request Updates',
        ),
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(
              item['title']![lang] ?? item['title']!['es']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              item['description']![lang] ?? item['description']!['es']!,
            ),
            trailing: Text(
              item['timestamp']![lang] ?? item['timestamp']!['es']!,
              style: const TextStyle(fontSize: 12),
            ),
          );
        },
      ),
    );
  }
}