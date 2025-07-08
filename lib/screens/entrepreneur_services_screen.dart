import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class Service {
  final String id;
  final String entrepreneurName;
  final Map<String, String> description;
  final double price;

  Service({
    required this.id,
    required this.entrepreneurName,
    required this.description,
    required this.price,
  });
}

class EntrepreneurServicesScreen extends StatefulWidget {
  const EntrepreneurServicesScreen({super.key});

  @override
  State<EntrepreneurServicesScreen> createState() => _EntrepreneurServicesScreenState();
}

class _EntrepreneurServicesScreenState extends State<EntrepreneurServicesScreen> {
  final List<Service> services = [
    Service(
      id: '1',
      entrepreneurName: 'Ana Morales',
      description: {
        'es': 'Asesoramiento financiero y estrategia de ahorro',
        'en': 'Financial advice and saving strategy',
      },
      price: 120.0,
    ),
    Service(
      id: '2',
      entrepreneurName: 'Carlos Ruiz',
      description: {
        'es': 'Planificación de inversiones para emprendedores.',
        'en': 'Investment planning for entrepreneurs.',
      },
      price: 180.0,
    ),
  ];

  final List<String> contractedServiceIds = [];

  void _confirmContract(BuildContext context, Service service, String lang) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(lang == 'es' ? '¿Confirmar contratación?' : 'Confirm Contract?'),
        content: Text(
          '${lang == 'es' ? '¿Deseas contratar el servicio de' : 'Do you want to hire the service of'} ${service.entrepreneurName} ${lang == 'es' ? 'por S/' : 'for \$'}${service.price.toStringAsFixed(2)}?\n\n${lang == 'es' ? 'Descripción' : 'Description'}:\n${service.description[lang]!}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(lang == 'es' ? 'Cancelar' : 'Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(ctx).pop();
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        lang == 'es' ? 'Procesando contratación...' : 'Processing contract...',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );

              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pop();

                setState(() {
                  contractedServiceIds.add(service.id);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      lang == 'es'
                          ? 'Has contratado a ${service.entrepreneurName} exitosamente.'
                          : 'You have successfully hired ${service.entrepreneurName}.',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              });
            },
            icon: const Icon(Icons.check),
            label: Text(lang == 'es' ? 'Confirmar' : 'Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Otros servicios de emprendedores' : 'Other entrepreneur Services'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          final isContracted = contractedServiceIds.contains(service.id);

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    isContracted ? Icons.verified : Icons.assignment_ind,
                    color: isContracted ? Colors.green : Colors.indigo,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(service.entrepreneurName,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(service.description[lang]!),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${lang == 'es' ? 'S/' : '\$'}${service.price.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            isContracted
                                ? Text(
                              lang == 'es' ? 'Contratado' : 'Hired',
                              style: const TextStyle(
                                  color: Colors.green, fontWeight: FontWeight.bold),
                            )
                                : OutlinedButton(
                              onPressed: () => _confirmContract(context, service, lang),
                              child: Text(lang == 'es' ? 'Contratar' : 'Hire'),
                            ),
                          ],
                        ),
                      ],
                    ),
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