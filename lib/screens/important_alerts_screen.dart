import 'package:flutter/material.dart';

class ImportantAlertsScreen extends StatelessWidget {
  const ImportantAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> alerts = [
      {
        'title': 'Reunión con consultor',
        'date': '28 jun 2025',
        'time': '10:00 AM',
        'type': 'Reunión'
      },
      {
        'title': 'Vencimiento de pago',
        'date': '30 jun 2025',
        'time': '11:59 PM',
        'type': 'Pago'
      },
      {
        'title': 'Recordatorio: revisión de gastos',
        'date': '01 jul 2025',
        'time': '08:00 AM',
        'type': 'Recordatorio'
      },
    ];

    IconData _getIcon(String type) {
      switch (type) {
        case 'Reunión':
          return Icons.event_available;
        case 'Pago':
          return Icons.payment;
        case 'Recordatorio':
          return Icons.alarm;
        default:
          return Icons.notifications;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Alertas Importantes')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(_getIcon(alert['type']!), color: Colors.indigo),
              title: Text(alert['title']!),
              subtitle: Text('${alert['date']} • ${alert['time']}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}