import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class ImportantAlertsScreen extends StatelessWidget {
  const ImportantAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    final List<Map<String, Map<String, String>>> alerts = [
      {
        'title': {
          'es': 'Reunión con consultor',
          'en': 'Meeting with consultant',
        },
        'date': {
          'es': '28 jun 2025',
          'en': 'Jun 28, 2025',
        },
        'time': {
          'es': '10:00 AM',
          'en': '10:00 AM',
        },
        'type': {
          'es': 'Reunión',
          'en': 'Meeting',
        },
      },
      {
        'title': {
          'es': 'Vencimiento de pago',
          'en': 'Payment due',
        },
        'date': {
          'es': '30 jun 2025',
          'en': 'Jun 30, 2025',
        },
        'time': {
          'es': '11:59 PM',
          'en': '11:59 PM',
        },
        'type': {
          'es': 'Pago',
          'en': 'Payment',
        },
      },
      {
        'title': {
          'es': 'Recordatorio: revisión de gastos',
          'en': 'Reminder: Expense review',
        },
        'date': {
          'es': '01 jul 2025',
          'en': 'Jul 01, 2025',
        },
        'time': {
          'es': '08:00 AM',
          'en': '08:00 AM',
        },
        'type': {
          'es': 'Recordatorio',
          'en': 'Reminder',
        },
      },
    ];

    IconData _getIcon(String type) {
      switch (type.toLowerCase()) {
        case 'reunión':
        case 'meeting':
          return Icons.event_available;
        case 'pago':
        case 'payment':
          return Icons.payment;
        case 'recordatorio':
        case 'reminder':
          return Icons.alarm;
        default:
          return Icons.notifications;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Alertas Importantes' : 'Important Alerts'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          final type = alert['type']?[lang] ?? alert['type']?['es'] ?? '';

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(_getIcon(type), color: Colors.indigo),
              title: Text(alert['title']?[lang] ?? alert['title']?['es'] ?? ''),
              subtitle: Text('${alert['date']?[lang]} • ${alert['time']?[lang]}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}