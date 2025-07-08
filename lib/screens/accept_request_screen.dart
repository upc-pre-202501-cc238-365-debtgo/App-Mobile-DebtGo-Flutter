import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/EntrepreneurRequest.dart';
import '../screens/advisor_selection_screen.dart'; // Asegúrate de importar esto
import '../services/language_service.dart';

class AcceptRequestScreen extends StatefulWidget {
  const AcceptRequestScreen({super.key});

  @override
  State<AcceptRequestScreen> createState() => _AcceptRequestScreenState();
}

class _AcceptRequestScreenState extends State<AcceptRequestScreen> {
  late List<EntrepreneurRequest> requests;

  @override
  void initState() {
    super.initState();
    requests = [
      EntrepreneurRequest(
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
      EntrepreneurRequest(
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

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es'
            ? 'Aceptar solicitud de emprendedor'
            : 'Accept Entrepreneur request'),
      ),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final caseItem = requests[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(caseItem.title[lang] ?? caseItem.title['es'] ?? ''),
              subtitle:
              Text(caseItem.description[lang] ?? caseItem.description['en'] ?? ''),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdvisorSelectionScreen(
                        requestTitle: caseItem.title[lang] ?? '',
                      ),
                    ),
                  );
                },
                child: Text(lang == 'es' ? 'Aceptar' : 'Accept'),
              ),
            ),
          );
        },
      ),
    );
  }
}