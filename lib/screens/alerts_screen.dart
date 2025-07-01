import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  final List<Map<String, String>> alerts = const [
    {
      'title': 'Reunión con Consultor',
      'date': '2025-07-05',
      'description': 'Reunión programada con Lucía Torres a las 10:00 AM',
    },
    {
      'title': 'Vencimiento de Cuota',
      'date': '2025-07-10',
      'description': 'Recuerda pagar tu cuota del préstamo empresarial',
    },
    {
      'title': 'Envío de documento',
      'date': '2025-07-12',
      'description': 'Fecha límite para enviar plan financiero mensual',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alertas de Fechas Importantes')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: alerts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final alert = alerts[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.notifications, color: Colors.indigo),
              title: Text(alert['title']!),
              subtitle: Text(alert['description']!),
              trailing: Text(alert['date']!),
            ),
          );
        },
      ),
    );
  }
}