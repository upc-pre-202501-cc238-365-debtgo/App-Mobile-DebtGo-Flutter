import 'package:flutter/material.dart';

class DebtManagementScreen extends StatelessWidget {
  const DebtManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> debts = [
      {
        'name': 'Préstamo Negocio',
        'amount': 1200.00,
        'dueDate': '2025-08-01',
        'status': 'Pendiente',
      },
      {
        'name': 'Tarjeta Crédito',
        'amount': 350.50,
        'dueDate': '2025-07-15',
        'status': 'Pagado',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Deudas')),
      body: debts.isEmpty
          ? const Center(
          child: Text('No tienes deudas registradas.',
              style: TextStyle(fontSize: 16, color: Colors.grey)))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: debts.length,
        itemBuilder: (context, index) {
          final debt = debts[index];
          final color = debt['status'] == 'Pagado'
              ? Colors.green
              : Colors.redAccent;

          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Icon(Icons.account_balance_wallet_rounded,
                  color: color),
              title: Text(
                debt['name'],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text('Vence: ${debt['dueDate']}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('\$${debt['amount'].toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    debt['status'],
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
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