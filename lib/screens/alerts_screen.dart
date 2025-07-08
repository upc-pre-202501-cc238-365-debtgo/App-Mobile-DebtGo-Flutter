import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    final alerts = [
      {
        'title': {
          'es': 'Reunión con Emprendedor',
          'en': 'Meeting with Entrepreneur',
        },
        'date': '2025-07-05',
        'description': {
          'es': 'Reunión programada con Lucía Torres a las 10:00 AM',
          'en': 'Scheduled meeting with Lucía Torres at 10:00 AM',
        },
      },
      {
        'title': {
          'es': 'Vencimiento de Cuota',
          'en': 'Payment Due',
        },
        'date': '2025-07-10',
        'description': {
          'es': 'Recuerda pagar tu cuota del préstamo empresarial',
          'en': 'Remember to pay your business loan installment',
        },
      },
      {
        'title': {
          'es': 'Envío de documento',
          'en': 'Document Submission',
        },
        'date': '2025-07-12',
        'description': {
          'es': 'Fecha límite para enviar plan financiero mensual',
          'en': 'Deadline to submit monthly financial plan',
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es'
            ? 'Alertas de Fechas Importantes'
            : 'Important Date Alerts'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: alerts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final alert = alerts[index];
          final isUrgent = DateTime.parse(alert['date'] as String).isBefore(
            DateTime.now().add(const Duration(days: 2)),
          );

          final titleMap = alert['title'] as Map<String, String>;
          final descriptionMap = alert['description'] as Map<String, String>;
          final date = alert['date'] as String? ?? '';

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(
                Icons.notifications_active,
                color: isUrgent ? Colors.red : Colors.indigo,
              ),
              title: Text(
                titleMap[lang] ?? titleMap['es']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                descriptionMap[lang] ?? descriptionMap['es']!,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(date),
                  if (isUrgent)
                    Text(
                      lang == 'es' ? '¡Urgente!' : 'Urgent!',
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}