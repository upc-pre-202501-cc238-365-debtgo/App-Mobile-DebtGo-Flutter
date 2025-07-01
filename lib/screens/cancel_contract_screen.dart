import 'package:flutter/material.dart';

class CancelContractScreen extends StatefulWidget {
  const CancelContractScreen({super.key});

  @override
  State<CancelContractScreen> createState() => _CancelContractScreenState();
}

class _CancelContractScreenState extends State<CancelContractScreen> {
  String _selectedConsultant = '';
  final _reasonController = TextEditingController();

  final List<String> _activeContracts = [
    'Contrato con Carlos Ramírez',
    'Contrato con Lucía Torres',
    'Contrato con Pedro Gómez',
  ];

  void _submitCancellation() {
    if (_selectedConsultant.isEmpty || _reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes seleccionar un contrato y escribir una razón')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Has cancelado $_selectedConsultant.\nMotivo: ${_reasonController.text.trim()}'),
      ),
    );

    // Aquí podrías comunicar la cancelación al backend
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cancelar Contrato')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Contrato activo',
                border: OutlineInputBorder(),
              ),
              items: _activeContracts
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedConsultant = value ?? ''),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _reasonController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Motivo de la cancelación',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.cancel),
                label: const Text('Cancelar contrato'),
                onPressed: _submitCancellation,
              ),
            ),
          ],
        ),
      ),
    );
  }
}