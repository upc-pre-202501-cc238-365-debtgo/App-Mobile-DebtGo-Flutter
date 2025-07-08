import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

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

  void _calculateBudget(String lang) {
    final income = double.tryParse(_incomeController.text.trim()) ?? 0;
    final expenses = double.tryParse(_expensesController.text.trim()) ?? 0;
    final goal = double.tryParse(_goalController.text.trim()) ?? 0;

    if (income <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(lang == 'es'
              ? 'El ingreso mensual debe ser mayor que cero'
              : 'Monthly income must be greater than zero'),
        ),
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
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Planificador de Presupuesto' : 'Budget Planner'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _incomeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: lang == 'es'
                    ? 'Ingreso mensual (S/)'
                    : 'Monthly income (S/)',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _expensesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: lang == 'es'
                    ? 'Gastos mensuales (S/)'
                    : 'Monthly expenses (S/)',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _goalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: lang == 'es'
                    ? 'Meta de ahorro mensual (S/)'
                    : 'Monthly savings goal (S/)',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.calculate),
                label: Text(lang == 'es'
                    ? 'Calcular presupuesto'
                    : 'Calculate budget'),
                onPressed: () => _calculateBudget(lang),
              ),
            ),
            const SizedBox(height: 24),
            if (_suggestedSaving != null)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        (lang == 'es'
                            ? 'Ahorro sugerido: S/ '
                            : 'Suggested saving: S/ ') +
                            _suggestedSaving!.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        (lang == 'es'
                            ? 'Balance luego de meta: S/ '
                            : 'Balance after goal: S/ ') +
                            _balance!.toStringAsFixed(2),
                      ),
                      if (_balance! < 0 || _balance! > 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            _balance! > 0
                                ? (lang == 'es'
                                ? 'Buen trabajo, estás en camino a tu meta.'
                                : 'Good job, you are on track to meet your goal.')
                                : (lang == 'es'
                                ? 'Revisa tus gastos, estás excediendo tu presupuesto.'
                                : 'Review your expenses, you are over budget.'),
                            style: TextStyle(
                              color: _balance! > 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
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