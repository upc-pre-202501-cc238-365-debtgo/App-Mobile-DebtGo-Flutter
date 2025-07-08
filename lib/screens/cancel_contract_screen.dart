import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class CancelContractScreen extends StatefulWidget {
  const CancelContractScreen({super.key});

  @override
  State<CancelContractScreen> createState() => _CancelContractScreenState();
}

class _CancelContractScreenState extends State<CancelContractScreen> {
  String? _selectedConsultant;
  final _reasonController = TextEditingController();
  final List<String> _activeContracts = [
    'Contrato con Alfonso Cáceres',
    'Contrato con Miguel Fuentes',
    'Contrato con Sofia Mendoza',
  ];
  final List<String> _canceledContracts = [];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _submitCancellation(String lang) {
    if (_selectedConsultant == null || _reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(lang == 'es'
              ? 'Selecciona un contrato y escribe una razón'
              : 'Select a contract and provide a reason'),
        ),
      );
      return;
    }

    setState(() {
      _canceledContracts.add(_selectedConsultant!);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          lang == 'es'
              ? 'Cancelado: $_selectedConsultant\nMotivo: ${_reasonController.text.trim()}'
              : 'Cancelled: $_selectedConsultant\nReason: ${_reasonController.text.trim()}',
        ),
        backgroundColor: Colors.redAccent,
      ),
    );

    _reasonController.clear();
    _selectedConsultant = null;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;
    final List<String> availableContracts = _activeContracts
        .where((contract) => !_canceledContracts.contains(contract))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Cancelar Contrato' : 'Cancel Contract'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedConsultant,
              decoration: InputDecoration(
                labelText: lang == 'es'
                    ? 'Contrato activo'
                    : 'Active contract',
                border: const OutlineInputBorder(),
              ),
              items: availableContracts
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedConsultant = value),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _reasonController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: lang == 'es'
                    ? 'Motivo de la cancelación'
                    : 'Reason for cancellation',
                border: const OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.cancel),
                label: Text(
                  lang == 'es' ? 'Cancelar contrato' : 'Cancel contract',
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(lang == 'es'
                          ? '¿Confirmar cancelación?'
                          : 'Confirm cancellation?'),
                      content: Text(lang == 'es'
                          ? '¿Deseas cancelar el contrato con $_selectedConsultant?'
                          : 'Do you want to cancel the contract with $_selectedConsultant?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(lang == 'es' ? 'No' : 'No'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _submitCancellation(lang);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          child: Text(lang == 'es'
                              ? 'Sí, cancelar'
                              : 'Yes, cancel'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}