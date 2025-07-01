import 'package:flutter/material.dart';

class BudgetPlanningScreen extends StatefulWidget {
  const BudgetPlanningScreen({super.key});

  @override
  State<BudgetPlanningScreen> createState() => _BudgetPlanningScreenState();
}

class _BudgetPlanningScreenState extends State<BudgetPlanningScreen> {
  final _incomeController = TextEditingController();
  final _expensesController = TextEditingController();
  final _goalController = TextEditingController();
  double? _suggestedSaving;
  double? _balance;

  void _calculateBudget() {
    final income = double.tryParse(_incomeController.text.trim()) ?? 0;
    final expenses = double.tryParse(_expensesController.text.trim()) ?? 0;
    final goal = double.tryParse(_goalController.text.trim()) ?? 0;

    if (income <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El ingreso mensual debe ser mayor que cero')),
      );
      return;
    }

    final remaining = income - expenses;
    final suggested = (income * 0.20).clamp(0, remaining); // Ahorro sugerido: 20%

    setState(() {
      _balance = remaining - goal;
      _suggestedSaving = suggested as double?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Planificador de Presupuesto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _incomeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingreso mensual (S/)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _expensesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Gastos mensuales (S/)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _goalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Meta de ahorro mensual (S/)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.calculate),
                label: const Text('Calcular presupuesto'),
                onPressed: _calculateBudget,
              ),
            ),
            const SizedBox(height: 24),
            if (_suggestedSaving != null)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Ahorro sugerido: S/ ${_suggestedSaving!.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Balance luego de meta: S/ ${_balance!.toStringAsFixed(2)}'),
                      if (_balance! < 0)
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            '⚠ Tu meta supera el monto disponible. Ajusta tu presupuesto.',
                            style: TextStyle(color: Colors.redAccent),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}