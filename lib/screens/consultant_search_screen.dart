import 'package:flutter/material.dart';

class ConsultantSearchScreen extends StatefulWidget {
  const ConsultantSearchScreen({super.key});

  @override
  State<ConsultantSearchScreen> createState() => _ConsultantSearchScreenState();
}

class _ConsultantSearchScreenState extends State<ConsultantSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _consultants = [
    {'name': 'Carlos Ramírez', 'expertise': 'Finanzas para pequeños negocios'},
    {'name': 'Lucía Torres', 'expertise': 'Microcréditos y préstamos'},
    {'name': 'Pedro Gómez', 'expertise': 'Planificación financiera'},
    {'name': 'María Soto', 'expertise': 'Gestión de deudas'},
  ];

  List<Map<String, String>> _filteredConsultants = [];

  @override
  void initState() {
    super.initState();
    _filteredConsultants = List.from(_consultants);
  }

  void _filterConsultants(String query) {
    setState(() {
      _filteredConsultants = _consultants
          .where((c) =>
      c['name']!.toLowerCase().contains(query.toLowerCase()) ||
          c['expertise']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Consultores')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _filterConsultants,
              decoration: const InputDecoration(
                labelText: 'Buscar por nombre o especialidad',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredConsultants.isEmpty
                  ? const Center(child: Text('No se encontraron consultores.'))
                  : ListView.builder(
                itemCount: _filteredConsultants.length,
                itemBuilder: (context, index) {
                  final consultant = _filteredConsultants[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(consultant['name']!),
                      subtitle: Text(consultant['expertise']!),
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