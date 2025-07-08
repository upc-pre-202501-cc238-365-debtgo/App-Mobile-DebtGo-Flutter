import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../services/language_service.dart';

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
      final lang = Provider.of<LanguageService>(context, listen: false).language;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(lang == 'es'
              ? 'Por favor ingresa valores válidos'
              : 'Please enter valid values'),
        ),
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
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Simulador de Pagos' : 'Payment Simulator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: lang == 'es'
                    ? 'Monto del préstamo (S/)'
                    : 'Loan amount (S/)',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _interestController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: lang == 'es'
                    ? 'Tasa de interés anual (%)'
                    : 'Annual interest rate (%)',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _monthsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: lang == 'es'
                    ? 'Cantidad de meses'
                    : 'Number of months',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _simulatePayment,
                icon: const Icon(Icons.calculate),
                label: Text(lang == 'es'
                    ? 'Calcular pago mensual'
                    : 'Calculate monthly payment'),
              ),
            ),
            const SizedBox(height: 24),
            if (_monthlyPayment != null)
              Text(
                lang == 'es'
                    ? 'Pago mensual estimado: S/ ${_monthlyPayment!.toStringAsFixed(2)}'
                    : 'Estimated monthly payment: S/ ${_monthlyPayment!.toStringAsFixed(2)}',
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