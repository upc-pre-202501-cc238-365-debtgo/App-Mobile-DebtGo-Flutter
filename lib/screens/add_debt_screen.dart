import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddDebtScreen extends StatefulWidget {
  const AddDebtScreen({super.key});

  @override
  State<AddDebtScreen> createState() => _AddDebtScreenState();
}

class _AddDebtScreenState extends State<AddDebtScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _dueDate;

  void _saveDebt() {
    if (_formKey.currentState!.validate() && _dueDate != null) {
      final name = _nameController.text.trim();
      final amount = double.parse(_amountController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deuda registrada: $name - \$${amount.toStringAsFixed(2)}')),
      );

      Navigator.pop(context); // Vuelve a la pantalla anterior
    } else if (_dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, seleccione una fecha de vencimiento')),
      );
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Ingrese un nombre válido';
    if (value.length < 3) return 'El nombre debe tener al menos 3 caracteres';
    return null;
  }

  String? _validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) return 'Ingrese un monto válido';
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) return 'El monto debe ser un número mayor que 0';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar nueva deuda')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la deuda',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
                validator: _validateName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Monto',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(),
                ),
                validator: _validateAmount,
              ),
              const SizedBox(height: 16),
              ListTile(
                tileColor: Colors.grey.shade100,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                title: Text(_dueDate == null
                    ? 'Seleccione fecha de vencimiento'
                    : 'Vence: ${DateFormat.yMMMMd('es_PE').format(_dueDate!)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveDebt,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar deuda'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}