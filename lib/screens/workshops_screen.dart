import 'package:flutter/material.dart';

class WorkshopsScreen extends StatelessWidget {
  const WorkshopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workshops = [
      {
        'title': 'Finanzas personales',
        'date': '15/07/2025',
        'desc': 'Aprende a presupuestar y ahorrar desde cero.',
      },
      {
        'title': 'Planificación para emprendedores',
        'date': '20/07/2025',
        'desc': 'Herramientas para estructurar tu negocio.',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Talleres Virtuales')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workshops.length,
        itemBuilder: (context, index) {
          final w = workshops[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.school, color: Colors.indigo),
              title: Text(w['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${w['date']} • ${w['desc']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Te has registrado a "${w['title']}"')),
                  );
                },
                child: const Text('Unirme'),
              ),
            ),
          );
        },
      ),
    );
  }
}