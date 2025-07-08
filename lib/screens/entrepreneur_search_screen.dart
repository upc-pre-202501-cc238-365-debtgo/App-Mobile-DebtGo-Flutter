import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';
import 'entrepreneur_profile_screen.dart';

class EntrepreneurSearchScreen extends StatefulWidget {
  const EntrepreneurSearchScreen({super.key});

  @override
  State<EntrepreneurSearchScreen> createState() => _EntrepreneurSearchScreenState();
}

class _EntrepreneurSearchScreenState extends State<EntrepreneurSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Map<String, Map<String, String>>>> _entrepreneursFuture;
  List<Map<String, Map<String, String>>> _allEntrepreneurs = [];
  List<Map<String, Map<String, String>>> _filteredEntrepreneurs = [];

  @override
  void initState() {
    super.initState();
    _entrepreneursFuture = _loadEntrepreneurs();
  }

  Future<List<Map<String, Map<String, String>>>> _loadEntrepreneurs() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return [
      {
        'name': {'es': 'Carlos Ramírez', 'en': 'Carlos Ramírez'},
        'expertise': {'es': 'Consolidación en deudas empresariales', 'en': 'Consolidation of business debts'},
      },
      {
        'name': {'es': 'Lucía Torres', 'en': 'Lucía Torres'},
        'expertise': {'es': 'Estrategias de flujo de efectivo', 'en': 'Cash flow strategies'},
      },
      {
        'name': {'es': 'Pedro Gómez', 'en': 'Pedro Gómez'},
        'expertise': {'es': 'Planes de pago personalizados', 'en': 'Customized payment plans'},
      },
      {
        'name': {'es': 'María Soto', 'en': 'María Soto'},
        'expertise': {'es': 'Expansión de negocios con préstamos', 'en': 'Business expansion with loans'},
      },
      {
        'name': {'es': 'Ana Martínez', 'en': 'Ana Martínez'},
        'expertise': {'es': 'Soluciones rápidas para deudas', 'en': 'Quick solutions for debts'},
      },
      {
        'name': {'es': 'Javier Paredes', 'en': 'Javier Paredes'},
        'expertise': {'es': 'Prevención de intereses adicionales', 'en': 'Prevention of additional interest'},
      },
      {
        'name': {'es': 'Laura Chávez', 'en': 'Laura Chávez'},
        'expertise': {'es': 'Reestructuración de obligaciones financieras', 'en': 'Restructuring of financial obligations'},
      },
      {
        'name': {'es': 'Luis Cárdenas', 'en': 'Luis Cárdenas'},
        'expertise': {'es': 'Evaluación financiera para nuevos negocios', 'en': 'Financial evaluation for new businesses'},
      },
      {
        'name': {'es': 'Sofía Mendoza', 'en': 'Sofía Mendoza'},
        'expertise': {'es': 'Gestión integral de deudas', 'en': 'Comprehensive debt management'},
      },
      {
        'name': {'es': 'Diego Salazar', 'en': 'Diego Salazar'},
        'expertise': {'es': 'Diagnóstico financiero empresarial', 'en': 'Business financial diagnosis'},
      },
      {
        'name': {'es': 'Andrea Ríos', 'en': 'Andrea Ríos'},
        'expertise': {'es': 'Optimización de pagos mensuales', 'en': 'Optimization of monthly payments'},
      },
      {
        'name': {'es': 'José Valdez', 'en': 'José Valdez'},
        'expertise': {'es': 'Capacitador para entornos empresariales', 'en': 'Trainer for business environments'},
      },
      {
        'name': {'es': 'Verónica León', 'en': 'Verónica León'},
        'expertise': {'es': 'Educación en finanzas empresariales', 'en': 'Business Finance Education'},
      },
      {
        'name': {'es': 'Ricardo Palma', 'en': 'Ricardo Palma'},
        'expertise': {'es': 'Asesoramiento para evitar mora crediticia', 'en': 'Advice to avoid credit default'},
      },
      {
        'name': {'es': 'Camila Alfaro', 'en': 'Camila Alfaro'},
        'expertise': {'es': 'Soluciones para liquidez inmediata', 'en': 'Solutions for immediate liquidity'},
      },
      {
        'name': {'es': 'Esteban Bravo', 'en': 'Esteban Bravo'},
        'expertise': {'es': 'Diseño de cronogramas de pago', 'en': 'Design of payment schedules'},
      },
      {
        'name': {'es': 'Natalia Guevara', 'en': 'Natalia Guevara'},
        'expertise': {'es': 'Herramientas para emprender sin deudas', 'en': 'Tools for starting a business without debt'},
      },
      {
        'name': {'es': 'Álvaro Mejía', 'en': 'Álvaro Mejía'},
        'expertise': {'es': 'Planificación financiera post-préstamo', 'en': 'Post-loan financial planning'},
      },
      {
        'name': {'es': 'Paula Cruz', 'en': 'Paula Cruz'},
        'expertise': {'es': 'Capacitadora en el logro de metas empresariales', 'en': 'Trainer in achieving business goals'},
      },
      {
        'name': {'es': 'Manuel Tapia', 'en': 'Manuel Tapia'},
        'expertise': {'es': 'Control financiero para emprendedores', 'en': 'Financial control for entrepreneurs'},
      },
    ];
  }

  void _filterEntrepreneurs(String query, String lang) {
    final lowercaseQuery = query.toLowerCase();
    setState(() {
      _filteredEntrepreneurs = _allEntrepreneurs.where((c) {
        final name = c['name']![lang]!.toLowerCase();
        final expertise = c['expertise']![lang]!.toLowerCase();
        return name.contains(lowercaseQuery) || expertise.contains(lowercaseQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).language;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'es' ? 'Buscar Emprendedores' : 'Search Entrepreneurs'),
      ),
      body: FutureBuilder<List<Map<String, Map<String, String>>>>(
        future: _entrepreneursFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(lang == 'es'
                  ? 'Error al cargar emprendedores.'
                  : 'Error loading entrepreneurs.'),
            );
          }

          if (_allEntrepreneurs.isEmpty) {
            _allEntrepreneurs = snapshot.data!;
            _filteredEntrepreneurs = _allEntrepreneurs;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) => _filterEntrepreneurs(value, lang),
                  decoration: InputDecoration(
                    labelText: lang == 'es'
                        ? 'Buscar por nombre o especialidad'
                        : 'Search by name or expertise',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _filteredEntrepreneurs.isEmpty
                      ? Center(
                    child: Text(lang == 'es'
                        ? 'No se encontraron emprendedores.'
                        : 'No entrepreneurs found.'),
                  )
                      : ListView.builder(
                    itemCount: _filteredEntrepreneurs.length,
                    itemBuilder: (context, index) {
                      final consultant = _filteredEntrepreneurs[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: const Icon(Icons.person_outline),
                          title: Text(
                            consultant['name']![lang]!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(consultant['expertise']![lang]!),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EntrepreneurProfileScreen(
                                  name: consultant['name']![lang]!,
                                  expertise: consultant['expertise']![lang]!,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}