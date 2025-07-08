import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class ConsultationCase {
  final String id;
  final Map<String, String> title;
  final Map<String, String> description;
  bool accepted;

  ConsultationCase({
    required this.id,
    required this.title,
    required this.description,
    this.accepted = false,
  });
}

class AcceptCaseScreen extends StatefulWidget {
  const AcceptCaseScreen({super.key});

  @override
  State<AcceptCaseScreen> createState() => _AcceptCaseScreenState();
}

class _AcceptCaseScreenState extends State<AcceptCaseScreen> {
  late List<ConsultationCase> cases;

  @override
  void initState() {
    super.initState();
    cases = [
      ConsultationCase(
        id: '1',
        title: {
          'es': 'Análisis de Crédito',
          'en': 'Credit Analysis',
        },
        description: {
          'es': '¿Necesita ayuda para comparar opciones de préstamos?',
          'en': 'Need help comparing loan options?',
        },
      ),
      ConsultationCase(
        id: '2',
        title: {
          'es': 'Planificación presupuestaria',
          'en': 'Budget Planning',
        },
        description: {
          'es': 'Buscando mejorar el ahorro mensual',
          'en': 'Looking to improve monthly savings',
        },
      ),
    ];
  }

  void _accept(int index, String lang) {
    setState(() {
      cases[index].accepted = true;
    });

    final message = lang == 'es'
        ? 'Caso "${cases[index].title[lang] ?? cases[index].title['es']}" aceptado'
        : 'Case "${cases[index].title[lang] ?? cases[index].title['en']}" accepted';

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es'
            ? 'Aceptar casos de consulta'
            : 'Accept Consultation Cases'),
      ),
      body: ListView.builder(
        itemCount: cases.length,
        itemBuilder: (context, index) {
          final caseItem = cases[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(caseItem.title[lang] ?? caseItem.title['es'] ?? ''),
              subtitle: Text(caseItem.description[lang] ?? caseItem.description['en'] ?? ''),
              trailing: ElevatedButton(
                onPressed: caseItem.accepted
                    ? null
                    : () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(lang == 'es'
                        ? 'Confirmar aceptación'
                        : 'Confirm Acceptance'),
                    content: Text(lang == 'es'
                        ? '¿Aceptar el caso "${caseItem.title[lang] ?? caseItem.title['es']}"?'
                        : 'Accept the case "${caseItem.title[lang] ?? caseItem.title['en']}"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(lang == 'es' ? 'Cancelar' : 'Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _accept(index, lang);
                        },
                        child: Text(lang == 'es' ? 'Aceptar' : 'Accept'),
                      ),
                    ],
                  ),
                ),
                child: Text(caseItem.accepted
                    ? (lang == 'es' ? 'Aceptado' : 'Accepted')
                    : (lang == 'es' ? 'Aceptar' : 'Accept')),
              ),
            ),
          );
        },
      ),
    );
  }
}