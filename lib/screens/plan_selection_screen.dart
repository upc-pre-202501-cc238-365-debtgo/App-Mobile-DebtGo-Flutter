import 'package:flutter/material.dart';
import 'checkout_screen.dart';

class PlanSelectionScreen extends StatefulWidget {
  const PlanSelectionScreen({super.key});

  @override
  State<PlanSelectionScreen> createState() => _PlanSelectionScreenState();
}

class _PlanSelectionScreenState extends State<PlanSelectionScreen> {
  String selectedPlan = '';

  final List<Map<String, dynamic>> plans = [
    {
      'name': 'Plan Básico',
      'price': 0.0,
      'features': [
        'Seguimiento de deudas',
        'Acceso limitado a contenido',
      ],
    },
    {
      'name': 'Plan Premium',
      'price': 9.99,
      'features': [
        'Todo del básico',
        'Consultoría personalizada',
        'Proyecciones financieras',
      ],
    },
  ];

  void _confirmPlan() {
    if (selectedPlan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona un plan antes de continuar')),
      );
      return;
    }

    final plan = plans.firstWhere((p) => p['name'] == selectedPlan);
    final price = plan['price'] as double;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutScreen(planName: selectedPlan, price: price),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar plan')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          final isSelected = plan['name'] == selectedPlan;

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: isSelected ? Colors.indigo : Colors.grey.shade300,
                width: 2,
              ),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                plan['name'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(plan['price'] == 0 ? 'Gratis' : '\$${plan['price']}/mes',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 12),
                  ...List<Widget>.from(
                    plan['features'].map(
                          (feature) => Row(
                        children: [
                          const Icon(Icons.check_circle, size: 18, color: Colors.indigo),
                          const SizedBox(width: 8),
                          Expanded(child: Text(feature)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              trailing: isSelected
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : null,
              onTap: () => setState(() => selectedPlan = plan['name']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _confirmPlan,
        icon: const Icon(Icons.done),
        label: const Text('Confirmar'),
      ),
    );
  }
}