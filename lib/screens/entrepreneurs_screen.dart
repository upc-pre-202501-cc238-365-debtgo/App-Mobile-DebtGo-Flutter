import 'package:flutter/material.dart';
import 'consultation_screen.dart';
import 'workshops_screen.dart';
import 'success_stories_screen.dart';

class EntrepreneursScreen extends StatelessWidget {
  const EntrepreneursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> resources = [
      {
        'title': 'Consultoría Personalizada',
        'subtitle': 'Recibe ayuda de un asesor financiero',
        'icon': Icons.support_agent,
        'description':
        'Nuestros asesores financieros te guiarán en decisiones clave para manejar tus deudas y potenciar tu emprendimiento.',
        'screen': const ConsultationScreen(),
      },
      {
        'title': 'Talleres Virtuales',
        'subtitle': 'Capacítate desde casa con expertos',
        'icon': Icons.school,
        'description':
        'Participa en talleres dictados por profesionales en finanzas y gestión empresarial.',
        'screen': const WorkshopsScreen(),
      },
      {
        'title': 'Casos de Éxito',
        'subtitle': 'Historias reales de emprendedores',
        'icon': Icons.emoji_events,
        'description':
        'Conoce testimonios de quienes salieron adelante con el apoyo de DebtGo.',
        'screen': const SuccessStoriesScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Emprendedores')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: resources.length,
        itemBuilder: (context, index) {
          final item = resources[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item['screen']),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(item['icon'], size: 36, color: Colors.indigo),
                      title: Text(
                        item['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(item['subtitle']),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['description'],
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}