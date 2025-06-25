import 'package:flutter/material.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> messages = [
      {
        'name': 'Asesor Juan',
        'lastMessage': 'Recuerda pagar antes del 10.',
        'time': '15:32',
      },
      {
        'name': 'Asesora Carla',
        'lastMessage': 'Revisé tu proyección. ¡Bien hecho!',
        'time': '14:15',
      },
      {
        'name': 'Asesor Luis',
        'lastMessage': 'Podemos reagendar la consultoría.',
        'time': '12:44',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Mensajes')),
      body: messages.isEmpty
          ? const Center(
        child: Text(
          'Aún no tienes conversaciones.',
          style: TextStyle(color: Colors.grey),
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: messages.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = messages[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(item['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item['lastMessage']!,
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: Text(item['time']!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(contactName: item['name']!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}