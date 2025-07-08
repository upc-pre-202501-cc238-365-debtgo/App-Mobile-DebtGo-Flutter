import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/advice_request.dart';
import '../provider/advice_request_provider.dart';
import '../services/language_service.dart';

class StartRequestScreen extends StatefulWidget {
  const StartRequestScreen({super.key});

  @override
  State<StartRequestScreen> createState() => _StartRequestScreenState();
}

class _StartRequestScreenState extends State<StartRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? selectedAdvisorName;
  String? selectedAdvisorEmail;

  final List<Map<String, String>> advisors = [
    {
      'name': 'Alfonso Cáceres',
      'email': 'alfonso.caceres@debtgo.com',
    },
    {
      'name': 'Miguel Fuentes',
      'email': 'miguel.fuentes@debtgo.com',
    },
    {
      'name': 'Sofía Mendoza',
      'email': 'sofia.mendoza@debtgo.com',
    },
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitCase(String lang) {
    if (_formKey.currentState!.validate() &&
        selectedAdvisorName != null &&
        selectedAdvisorEmail != null) {
      Provider.of<AdviceRequestProvider>(context, listen: false).addRequest(
        AdviceRequest(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          advisorName: selectedAdvisorName!,
          advisorEmail: selectedAdvisorEmail!,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(lang == 'es'
              ? 'Solicitud enviada exitosamente'
              : 'Request submitted successfully'),
        ),
      );

      _formKey.currentState!.reset();
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        selectedAdvisorName = null;
        selectedAdvisorEmail = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(lang == 'es'
              ? 'Por favor selecciona un asesor'
              : 'Please select an advisor'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es'
            ? 'Iniciar una solicitud de asesoría'
            : 'Start a Advice request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: lang == 'es' ? 'Título' : 'Title',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return lang == 'es'
                        ? 'Ingresa un título válido'
                        : 'Enter a valid title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: lang == 'es' ? 'Descripción' : 'Description',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().length < 10) {
                    return lang == 'es'
                        ? 'La descripción debe tener al menos 10 caracteres'
                        : 'Description must be at least 10 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedAdvisorName,
                decoration: InputDecoration(
                  labelText: lang == 'es'
                      ? 'Selecciona un asesor'
                      : 'Select an advisor',
                ),
                items: advisors.map((advisor) {
                  return DropdownMenuItem<String>(
                    value: advisor['name'],
                    child: Text(advisor['name']!),
                  );
                }).toList(),
                onChanged: (value) {
                  final advisor = advisors.firstWhere(
                          (a) => a['name'] == value,
                      orElse: () => {});
                  setState(() {
                    selectedAdvisorName = advisor['name'];
                    selectedAdvisorEmail = advisor['email'];
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return lang == 'es'
                        ? 'Selecciona un asesor válido'
                        : 'Please select a valid advisor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _submitCase(lang),
                icon: const Icon(Icons.send),
                label: Text(lang == 'es' ? 'Enviar' : 'Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}