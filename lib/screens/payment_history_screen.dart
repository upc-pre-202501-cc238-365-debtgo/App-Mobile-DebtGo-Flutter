import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> payments = [
      {
        'name': 'Préstamo Negocio',
        'amount': 800.00,
        'date': '2025-06-01',
        'status': 'Pagado',
      },
      {
        'name': 'Tarjeta de Crédito',
        'amount': 300.00,
        'date': '2025-06-10',
        'status': 'Pendiente',
      },
      {
        'name': 'Crédito Universitario',
        'amount': 1000.00,
        'date': '2025-05-15',
        'status': 'Atrasado',
      },
    ];

    Color _getStatusColor(String status) {
      switch (status) {
        case 'Pagado':
          return Colors.green;
        case 'Pendiente':
          return Colors.orange;
        case 'Atrasado':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    IconData _getStatusIcon(String status) {
      switch (status) {
        case 'Pagado':
          return Icons.check_circle;
        case 'Pendiente':
          return Icons.pending_actions;
        case 'Atrasado':
          return Icons.warning_amber_rounded;
        default:
          return Icons.info_outline;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de Pagos')),
      body: payments.isEmpty
          ? const Center(
          child: Text('Aún no tienes pagos registrados.',
              style: TextStyle(fontSize: 16, color: Colors.grey)))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: payments.length,
        itemBuilder: (context, index) {
          final item = payments[index];
          final color = _getStatusColor(item['status']);
          final icon = _getStatusIcon(item['status']);

          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(icon, color: color),
              title: Text(
                item['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Fecha: ${item['date']}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('\$${item['amount'].toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(item['status'], style: TextStyle(color: color)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}