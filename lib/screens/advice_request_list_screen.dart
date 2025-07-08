import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/advice_request_provider.dart';
import '../services/language_service.dart';

class AdviceRequestListScreen extends StatelessWidget {
  const AdviceRequestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final requests = Provider.of<AdviceRequestProvider>(context).requests;
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Solicitudes de Asesoría' : 'Advice Requests'),
      ),
      body: requests.isEmpty
          ? Center(
        child: Text(
          lang == 'es' ? 'No hay solicitudes registradas.' : 'No requests submitted yet.',
          style: const TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.assignment_turned_in),
              title: Text(request.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(request.description),
                  const SizedBox(height: 8),
                  Text(
                    '${lang == 'es' ? 'Asesor' : 'Advisor'}: ${request.advisorName}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${lang == 'es' ? 'Correo' : 'Email'}: ${request.advisorEmail}',
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}