import 'package:flutter/material.dart';

class ServiceComparisonScreen extends StatelessWidget {
  const ServiceComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'name': 'Asesoría Básica',
        'price': 50.0,
        'duration': '30 min',
        'includesChat': true,
      },
      {
        'name': 'Plan Avanzado',
        'price': 90.0,
        'duration': '1 hora',
        'includesChat': true,
      },
      {
        'name': 'Consulta Exprés',
        'price': 30.0,
        'duration': '20 min',
        'includesChat': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Comparar Servicios')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Servicio')),
            DataColumn(label: Text('Precio')),
            DataColumn(label: Text('Duración')),
            DataColumn(label: Text('Incluye chat')),
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