import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

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

  void _addRecord(String lang) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _records.add({
          'type': _type,
          'description': _descController.text.trim(),
          'amount': double.parse(_amountController.text.trim())
        });
        _amountController.clear();
        _descController.clear();
        _type = lang == 'es' ? 'Ingreso' : 'Income';
      });
      Navigator.pop(context);
    }
  }

  void _openAddDialog(String lang) {
    final incomeLabel = lang == 'es' ? 'Ingreso' : 'Income';
    final expenseLabel = lang == 'es' ? 'Gasto' : 'Expense';

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
                Text(
                  lang == 'es' ? 'Nuevo Registro' : 'New Record',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                DropdownButtonFormField<String>(
                  value: _type,
                  decoration: InputDecoration(
                    labelText: lang == 'es' ? 'Tipo' : 'Type',
                    border: const OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(value: incomeLabel, child: Text(incomeLabel)),
                    DropdownMenuItem(value: expenseLabel, child: Text(expenseLabel)),
                  ],
                  onChanged: (value) => setState(() => _type = value!),
                ),
                TextFormField(
                  controller: _descController,
                  decoration: InputDecoration(
                    labelText: lang == 'es' ? 'Descripción' : 'Description',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? (lang == 'es' ? 'Campo obligatorio' : 'Required field')
                      : null,
                ),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: lang == 'es' ? 'Monto' : 'Amount',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) {
                    final n = double.tryParse(v ?? '');
                    if (n == null || n <= 0) {
                      return lang == 'es' ? 'Monto no válido' : 'Invalid amount';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: Text(lang == 'es' ? 'Guardar' : 'Save'),
                    onPressed: () => _addRecord(lang),
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
    final lang = Provider.of<LanguageService>(context).language;
    final incomeLabel = lang == 'es' ? 'Ingreso' : 'Income';
    final expenseLabel = lang == 'es' ? 'Gasto' : 'Expense';

    if (_type != incomeLabel && _type != expenseLabel) {
      _type = incomeLabel;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es'
            ? 'Seguimiento de Ingresos y Gastos'
            : 'Income and Expense Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.pie_chart, color: Colors.indigo),
                title: Text(lang == 'es' ? 'Resumen Mensual' : 'Monthly Summary'),
                subtitle: Text(
                  '${lang == 'es' ? 'Ingresos' : 'Income'}: S/ ${totalIncome.toStringAsFixed(2)}\n'
                      '${lang == 'es' ? 'Gastos' : 'Expenses'}: S/ ${totalExpense.toStringAsFixed(2)}',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _records.isEmpty
                  ? Center(
                child: Text(lang == 'es'
                    ? 'No hay registros aún.'
                    : 'No records yet.'),
              )
                  : ListView.builder(
                itemCount: _records.length,
                itemBuilder: (context, index) {
                  final r = _records[index];
                  final isIncome = r['type'] == 'Ingreso' || r['type'] == 'Income';
                  final color = isIncome ? Colors.green : Colors.redAccent;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        isIncome ? Icons.trending_up : Icons.trending_down,
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
        onPressed: () => _openAddDialog(lang),
        child: const Icon(Icons.add),
      ),
    );
  }
}