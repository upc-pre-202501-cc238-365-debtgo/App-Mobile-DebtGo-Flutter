import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final String planName;
  final double price;

  const CheckoutScreen({
    super.key,
    required this.planName,
    required this.price,
  });

  void _simulatePayment(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('✅ Pago exitoso'),
        content: Text('Has adquirido el $planName por ${price == 0 ? 'Gratis' : '\$${price.toStringAsFixed(2)}'}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra dialog
              Navigator.pop(context); // Vuelve atrás
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('¡Plan activado correctamente!')),
              );
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFree = price == 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Confirmar pago')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Resumen de tu plan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.workspace_premium, color: Colors.indigo),
                title: Text(planName),
                subtitle: Text(isFree
                    ? 'Plan gratuito'
                    : 'Precio: \$${price.toStringAsFixed(2)}'),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => _simulatePayment(context),
              icon: const Icon(Icons.credit_card),
              label: const Text('Pagar ahora'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}