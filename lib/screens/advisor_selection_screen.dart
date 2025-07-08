import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class Advisor {
  final String name;
  final Map<String, String> specialty;
  final String email;
  final int experience;

  Advisor({
    required this.name,
    required this.specialty,
    required this.email,
    required this.experience,
  });
}

class AdvisorSelectionScreen extends StatelessWidget {
  final String requestTitle;

  AdvisorSelectionScreen({super.key, required this.requestTitle});

  final List<Advisor> advisors = [
    Advisor(
      name: 'Alfonso Cáceres',
      specialty: {
        'es': 'Especialista en reestructuración financiera',
        'en': 'Specialist in financial restructuring'
      },
      email: 'alfonso.caceres@debtgo.com',
      experience: 8,
    ),
    Advisor(
      name: 'Miguel Fuentes',
      specialty: {
        'es': 'Asesor en préstamos para emprendedores',
        'en': 'Advisor in entrepreneur loans'
      },
      email: 'miguel.fuentes@debtgo.com',
      experience: 5,
    ),
    Advisor(
      name: 'Sofía Mendoza',
      specialty: {
        'es': 'Experta en flujo de caja para PYMEs',
        'en': 'Expert in cash flow for SMEs'
      },
      email: 'sofia.mendoza@debtgo.com',
      experience: 7,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es'
            ? 'Seleccionar asesor para "$requestTitle"'
            : 'Select advisor for "$requestTitle"'),
      ),
      body: ListView.builder(
        itemCount: advisors.length,
        itemBuilder: (context, index) {
          final advisor = advisors[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(advisor.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(advisor.specialty[lang]!),
                  Text('📧 ${advisor.email}'),
                  Text(lang == 'es'
                      ? 'Experiencia: ${advisor.experience} años'
                      : 'Experience: ${advisor.experience} years'),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(lang == 'es'
                        ? 'Has seleccionado a ${advisor.name} como asesor.'
                        : 'You have selected ${advisor.name} as advisor.'),
                  ));
                },
                child: Text(lang == 'es' ? 'Elegir' : 'Select'),
              ),
            ),
          );
        },
      ),
    );
  }
}