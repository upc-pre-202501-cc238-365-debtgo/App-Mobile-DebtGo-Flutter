import 'package:flutter/material.dart';
import 'dart:math';

class PaymentSimulatorScreen extends StatefulWidget {
  const PaymentSimulatorScreen({super.key});

  @override
  State<PaymentSimulatorScreen> createState() => _PaymentSimulatorScreenState();
}

class _PaymentSimulatorScreenState extends State<PaymentSimulatorScreen> {
  final _amountController = TextEditingController();
  final _interestController = TextEditingController();
  final _monthsController = TextEditingController();
  double? _monthlyPayment;

  void _simulatePayment() {
    final double? principal = double.tryParse(_amountController.text.trim());
    final double? annualRate = double.tryParse(_interestController.text.trim());
    final int? months = int.tryParse(_monthsController.text.trim());

    if (principal == null || annualRate == null || months == null || months <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa valores válidos')),
      );
      return;
    }

    final monthlyRate = (annualRate / 100) / 12;
    final double result;

    if (monthlyRate == 0) {
      result = principal / months;
    } else {
      result = principal *
          (monthlyRate * pow(1 + monthlyRate, months)) /
          (pow(1 + monthlyRate, months) - 1);
    }

    setState(() => _monthlyPayment = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simulador de Pagos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Monto del préstamo (S/)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _interestController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tasa de interés anual (%)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _monthsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cantidad de meses',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _simulatePayment,
                icon: const Icon(Icons.calculate),
                label: const Text('Calcular pago mensual'),
              ),
            ),
            const SizedBox(height: 24),
            if (_monthlyPayment != null)
              Text(
                'Pago mensual estimado: S/ ${_monthlyPayment!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
          ],
        ),
      ),
    );
  }
}