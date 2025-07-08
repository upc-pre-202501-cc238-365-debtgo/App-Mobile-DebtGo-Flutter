import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class StartCaseScreen extends StatefulWidget {
  const StartCaseScreen({super.key});

  @override
  State<StartCaseScreen> createState() => _StartCaseScreenState();
}

class _StartCaseScreenState extends State<StartCaseScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitCase(String lang) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(lang == 'es'
              ? 'Caso enviado exitosamente'
              : 'Case submitted successfully'),
        ),
      );
      _titleController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es'
            ? 'Iniciar un caso de asesoría'
            : 'Start a Consulting Case'),
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