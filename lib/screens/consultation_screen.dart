import 'package:flutter/material.dart';

class ConsultationScreen extends StatelessWidget {
  const ConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final advisors = ['Asesor Juan', 'Asesora Carla', 'Asesor Luis'];

    return Scaffold(
      appBar: AppBar(title: const Text('Agendar Consultoría')),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: advisors.length,
        itemBuilder: (_, index) {
          final name = advisors[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.indigo, size: 30),
              title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Disponible esta semana'),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Consultoría solicitada con $name')),
                  );
                },
                child: const Text('Agendar'),
              ),
            ),
          );
        },
      ),
    );
  }
}