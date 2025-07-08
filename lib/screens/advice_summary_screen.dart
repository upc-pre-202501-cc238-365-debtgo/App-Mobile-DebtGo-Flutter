import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/advice_request_provider.dart';
import '../services/language_service.dart';

class AdviceSummaryScreen extends StatelessWidget {
  const AdviceSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;
    final adviceRequests = Provider.of<AdviceRequestProvider>(context).requests;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Mis asesorías' : 'My Consultations'),
      ),
      body: adviceRequests.isEmpty
          ? Center(
        child: Text(lang == 'es'
            ? 'Aún no tienes asesorías registradas.'
            : 'No consultations registered yet.'),
      )
          : ListView.builder(
        itemCount: adviceRequests.length,
        itemBuilder: (context, index) {
          final req = adviceRequests[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(req.title),
              subtitle: Text('${req.description}\n👤 ${req.advisorName}\n📧 ${req.advisorEmail}'),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}