import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class ConsultantSearchScreen extends StatefulWidget {
  const ConsultantSearchScreen({super.key});

  @override
  State<ConsultantSearchScreen> createState() => _ConsultantSearchScreenState();
}

class _ConsultantSearchScreenState extends State<ConsultantSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, Map<String, String>>> _consultants = [
    {
      'name': {'es': 'Carlos Ramírez', 'en': 'Carlos Ramírez'},
      'expertise': {
        'es': 'Finanzas para pequeños negocios',
        'en': 'Finance for small businesses'
      },
    },
    {
      'name': {'es': 'Lucía Torres', 'en': 'Lucía Torres'},
      'expertise': {
        'es': 'Microcréditos y préstamos',
        'en': 'Microcredits and loans'
      },
    },
    {
      'name': {'es': 'Pedro Gómez', 'en': 'Pedro Gómez'},
      'expertise': {
        'es': 'Planificación financiera',
        'en': 'Financial planning'
      },
    },
    {
      'name': {'es': 'María Soto', 'en': 'María Soto'},
      'expertise': {
        'es': 'Gestión de deudas',
        'en': 'Debt management'
      },
    },
  ];

  List<Map<String, Map<String, String>>> _filteredConsultants = [];

  @override
  void initState() {
    super.initState();
    _filteredConsultants = List.from(_consultants);
  }

  void _filterConsultants(String query, String lang) {
    setState(() {
      _filteredConsultants = _consultants
          .where((c) =>
      c['name']![lang]!.toLowerCase().contains(query.toLowerCase()) ||
          c['expertise']![lang]!
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Buscar Consultores' : 'Search Consultants'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) => _filterConsultants(value, lang),
              decoration: InputDecoration(
                labelText: lang == 'es'
                    ? 'Buscar por nombre o especialidad'
                    : 'Search by name or expertise',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredConsultants.isEmpty
                  ? Center(
                child: Text(lang == 'es'
                    ? 'No se encontraron consultores.'
                    : 'No consultants found.'),
              )
                  : ListView.builder(
                itemCount: _filteredConsultants.length,
                itemBuilder: (context, index) {
                  final consultant = _filteredConsultants[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(consultant['name']![lang]!),
                      subtitle: Text(consultant['expertise']![lang]!),
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