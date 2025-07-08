import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class EntrepreneurProfileScreen extends StatelessWidget {
  final String name;
  final String expertise;

  const EntrepreneurProfileScreen({
    super.key,
    required this.name,
    required this.expertise,
  });

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Perfil del Emprendedor' : 'Entrepeneur Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.indigo.shade100,
              child: const Icon(Icons.person, size: 60, color: Colors.indigo),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              expertise,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1.5),
            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(Icons.mail_outline, color: Colors.grey),
                const SizedBox(width: 10),
                Text(lang == 'es' ? 'Correo:' : 'Email:'),
                const SizedBox(width: 6),
                Text('${name.toLowerCase().replaceAll(' ', '.')}@debtgo.com',
                    style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.verified, color: Colors.grey),
                const SizedBox(width: 10),
                Text(lang == 'es' ? 'Experiencia:' : 'Experience:'),
                const SizedBox(width: 6),
                Text(lang == 'es' ? '5 años' : '5 years',
                    style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),

            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(lang == 'es'
                      ? 'Mensaje enviado al emprendedor.'
                      : 'Message sent to entrepeneur.'),
                  duration: const Duration(seconds: 2),
                ));
              },
              icon: const Icon(Icons.mail, color: Colors.white),
              label: Text(lang == 'es' ? 'Contactar' : 'Contact',
              style: const TextStyle(color: Colors.white),
            ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                minimumSize: const Size.fromHeight(48),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(lang == 'es'
                      ? 'Cita agendada con éxito.'
                      : 'Appointment scheduled successfully.'),
                  duration: const Duration(seconds: 2),
                ));
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(lang == 'es' ? 'Agendar Cita' : 'Schedule Appointment'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.indigo,
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}