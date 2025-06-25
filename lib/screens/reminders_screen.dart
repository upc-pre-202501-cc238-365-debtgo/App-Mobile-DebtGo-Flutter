import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import 'package:intl/intl.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  final List<Map<String, String>> _reminders = [];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime? _selectedDate;

  void _addReminder() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final name = _nameController.text.trim();
      final note = _noteController.text.trim();
      final date = _selectedDate!.toIso8601String().split('T').first;

      setState(() {
        _reminders.add({'name': name, 'note': note, 'date': date});
        _nameController.clear();
        _noteController.clear();
        _selectedDate = null;
      });

      NotificationService.showScheduledNotification(
        id: _reminders.length + 1,
        title: 'Recordatorio de Deuda',
        body: 'No olvides pagar: $name',
        scheduledDate: _selectedDate!,
      );

      Navigator.pop(context);
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una fecha para el recordatorio')),
      );
    }
  }

  void _openAddReminderDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                const Text('Nuevo Recordatorio',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de la deuda',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Campo requerido' : null,
                ),
                TextFormField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: 'Nota adicional (opcional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  tileColor: Colors.grey.shade100,
                  title: Text(_selectedDate == null
                      ? 'Selecciona fecha de vencimiento'
                      : 'Fecha: ${DateFormat.yMMMd('es_PE').format(_selectedDate!)}'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(const Duration(days: 1)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) {
                      setState(() => _selectedDate = picked);
                    }
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _addReminder,
                    icon: const Icon(Icons.save),
                    label: const Text('Guardar recordatorio'),
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
      appBar: AppBar(title: const Text('Recordatorios')),
      body: _reminders.isEmpty
          ? const Center(
        child: Text('No hay recordatorios aún.',
            style: TextStyle(fontSize: 16, color: Colors.grey)),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _reminders.length,
        itemBuilder: (context, index) {
          final reminder = _reminders[index];
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.alarm),
              title: Text(reminder['name']!),
              subtitle: Text(
                '${reminder['note']!.isEmpty ? 'Sin nota' : reminder['note']!}\nFecha: ${reminder['date']}',
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddReminderDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}