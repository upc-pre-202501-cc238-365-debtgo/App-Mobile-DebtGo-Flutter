import 'package:flutter/material.dart';

class SuccessStoriesScreen extends StatelessWidget {
  const SuccessStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = [
      {
        'name': 'María G.',
        'story': 'Pagó sus deudas en 6 meses gracias a un plan personalizado.',
      },
      {
        'name': 'Pedro R.',
        'story': 'Transformó su negocio con el seguimiento de DebtGo.',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Casos de Éxito')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: stories.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final s = stories[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.emoji_events, size: 32, color: Colors.amber),
              title: Text(s['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(s['story']!),
            ),
          );
        },
      ),
    );
  }
}