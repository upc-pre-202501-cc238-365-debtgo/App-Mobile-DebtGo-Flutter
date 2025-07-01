import 'package:flutter/material.dart';

class IncomeExpenseScreen extends StatefulWidget {
  const IncomeExpenseScreen({super.key});

  @override
  State<IncomeExpenseScreen> createState() => _IncomeExpenseScreenState();
}

class _IncomeExpenseScreenState extends State<IncomeExpenseScreen> {
  final List<Map<String, dynamic>> _records = [];
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descController = TextEditingController();
  String _type = 'Ingreso';

  double get totalIncome => _records
      .where((r) => r['type'] == 'Ingreso')
      .fold(0.0, (sum, r) => sum + r['amount']);

  double get totalExpense => _records
      .where((r) => r['type'] == 'Gasto')
      .fold(0.0, (sum, r) => sum + r['amount']);

  void _addRecord() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _records.add({
          'type': _type,
          'description': _descController.text.trim(),
          'amount': double.parse(_amountController.text.trim())
        });
        _amountController.clear();
        _descController.clear();
        _type = 'Ingreso';
      });
      Navigator.pop(context);
    }
  }

  void _openAddDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Wrap(
              runSpacing: 16,
              children: [
                const Text('Nuevo Registro',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                DropdownButtonFormField<String>(
                  value: _type,
                  decoration: const InputDecoration(
                    labelText: 'Tipo',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Ingreso', child: Text('Ingreso')),
                    DropdownMenuItem(value: 'Gasto', child: Text('Gasto')),
                  ],
                  onChanged: (value) => setState(() => _type = value!),
                ),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Campo obligatorio'
                      : null,
                ),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Monto',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    final n = double.tryParse(v ?? '');
                    if (n == null || n <= 0) return 'Monto no válido';
                    return null;
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Guardar'),
                    onPressed: _addRecord,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seguimiento de Ingresos y Gastos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.pie_chart, color: Colors.indigo),
                title: const Text('Resumen Mensual'),
                subtitle: Text(
                  'Ingresos: S/ ${totalIncome.toStringAsFixed(2)}\nGastos: S/ ${totalExpense.toStringAsFixed(2)}',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _records.isEmpty
                  ? const Center(child: Text('No hay registros aún.'))
                  : ListView.builder(
                itemCount: _records.length,
                itemBuilder: (context, index) {
                  final r = _records[index];
                  final color = r['type'] == 'Ingreso'
                      ? Colors.green
                      : Colors.redAccent;
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        r['type'] == 'Ingreso'
                            ? Icons.trending_up
                            : Icons.trending_down,
                        color: color,
                      ),
                      title: Text(r['description']),
                      trailing: Text(
                        'S/ ${r['amount'].toStringAsFixed(2)}',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}