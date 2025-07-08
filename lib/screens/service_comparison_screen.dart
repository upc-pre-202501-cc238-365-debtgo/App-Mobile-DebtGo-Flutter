import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class ServiceComparisonScreen extends StatelessWidget {
  const ServiceComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    final List<Map<String, dynamic>> services = [
      {
        'name': lang == 'es' ? 'Asesoría Básica' : 'Basic Advisory',
        'price': 50.0,
        'duration': lang == 'es' ? '30 min' : '30 min',
        'includesChat': true,
      },
      {
        'name': lang == 'es' ? 'Plan Avanzado' : 'Advanced Plan',
        'price': 90.0,
        'duration': lang == 'es' ? '1 hora' : '1 hour',
        'includesChat': true,
      },
      {
        'name': lang == 'es' ? 'Consulta Exprés' : 'Express Consultation',
        'price': 30.0,
        'duration': lang == 'es' ? '20 min' : '20 min',
        'includesChat': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Comparar Servicios' : 'Compare Services'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        child: DataTable(
          columns: [
            DataColumn(label: Text(lang == 'es' ? 'Servicio' : 'Service')),
            DataColumn(label: Text(lang == 'es' ? 'Precio' : 'Price')),
            DataColumn(label: Text(lang == 'es' ? 'Duración' : 'Duration')),
            DataColumn(label: Text(lang == 'es' ? 'Incluye chat' : 'Includes Chat')),
          ],
          rows: services.map((service) {
            return DataRow(cells: [
              DataCell(Text(service['name'])),
              DataCell(Text('S/ ${service['price'].toStringAsFixed(2)}')),
              DataCell(Text(service['duration'])),
              DataCell(Icon(
                service['includesChat'] ? Icons.check_circle : Icons.cancel,
                color: service['includesChat'] ? Colors.green : Colors.red,
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}