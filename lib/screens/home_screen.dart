import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';
import '../services/language_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String _userName = 'Usuario';
  List<AnimationController>? _controllers;
  bool _hasNotification = false;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadNotificationStatus();
    _checkPendingNavigation();
  }

  Future<void> _checkPendingNavigation() async {
    final prefs = await SharedPreferences.getInstance();
    final shouldNavigate = prefs.getBool('navigateToNotifications') ?? false;
    if (shouldNavigate) {
      await prefs.setBool('navigateToNotifications', false);
      Future.microtask(() {
        Navigator.pushNamed(context, AppRoutes.notifications);
      });
    }
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('name') ?? 'Usuario';
    });
  }

  Future<void> _loadNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasNotification = prefs.getBool('hasNotification') ?? false;
    });
  }

  @override
  void dispose() {
    if (_controllers != null) {
      for (final controller in _controllers!) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).locale.languageCode;

    final List<Map<String, dynamic>> options = [
      {
        'title': lang == 'en' ? 'Profile' : 'Perfil',
        'subtitle': lang == 'en' ? 'Your info' : 'Tus datos',
        'icon': Icons.person,
        'route': AppRoutes.profile,
      },
      {
        'title': lang == 'en' ? 'Reviews' : 'Reseñas',
        'subtitle': lang == 'en' ? 'User feedback' : 'Opiniones de usuarios',
        'icon': Icons.reviews,
        'route': AppRoutes.reviews,
      },
      {
        'title': lang == 'en' ? 'Find Consultants' : 'Buscar Consultores',
        'subtitle': lang == 'en' ? 'Filter by sector' : 'Filtra por rubro',
        'icon': Icons.search,
        'route': AppRoutes.consultantSearch,
      },
      {
        'title': lang == 'en' ? 'Compare Services' : 'Comparar Servicios',
        'subtitle': lang == 'en' ? 'Compare your options' : 'Compara tus opciones',
        'icon': Icons.compare_arrows,
        'route': AppRoutes.serviceComparison,
      },
      {
        'title': lang == 'en' ? 'Date Alerts' : 'Alertas de Fechas',
        'subtitle': lang == 'en' ? 'Meetings, payments' : 'Reuniones, pagos, vencimientos',
        'icon': Icons.calendar_today,
        'route': AppRoutes.alerts,
      },
      {
        'title': lang == 'en' ? 'Rate Service' : 'Calificar Servicio',
        'subtitle': lang == 'en' ? 'Evaluate your advisor' : 'Evalúa tu asesoría',
        'icon': Icons.star_rate,
        'route': AppRoutes.serviceRating,
      },
      {
        'title': lang == 'en' ? 'Cancel Contract' : 'Cancelar Contrato',
        'subtitle': lang == 'en' ? 'Cancel if not met' : 'Cancela si no cumple',
        'icon': Icons.cancel_presentation,
        'route': AppRoutes.cancelContract,
      },
      {
        'title': lang == 'en' ? 'Payment Simulator' : 'Simulador de Pagos',
        'subtitle': lang == 'en' ? 'Loans and fees' : 'Cuotas y préstamos',
        'icon': Icons.calculate,
        'route': AppRoutes.paymentSimulator,
      },
      {
        'title': lang == 'en' ? 'Income & Expenses' : 'Ingresos y Gastos',
        'subtitle': lang == 'en' ? 'Finance control' : 'Control financiero',
        'icon': Icons.bar_chart,
        'route': AppRoutes.incomeExpense,
      },
      {
        'title': lang == 'en' ? 'Budget' : 'Presupuesto',
        'subtitle': lang == 'en' ? 'Plan your finances' : 'Planifica tus finanzas',
        'icon': Icons.account_balance_wallet,
        'route': AppRoutes.budgetPlanning,
      },
      {
        'title': lang == 'en' ? 'Start Consulting' : 'Iniciar Asesoría',
        'subtitle': lang == 'en' ? 'Get help' : 'Solicita ayuda personalizada',
        'icon': Icons.assignment,
        'route': AppRoutes.startCase,
      },
      {
        'title': lang == 'en' ? 'Accept Case' : 'Aceptar Asesoría',
        'subtitle': lang == 'en' ? 'Manage pending' : 'Gestiona casos pendientes',
        'icon': Icons.how_to_reg,
        'route': AppRoutes.acceptCase,
      },
      {
        'title': lang == 'en' ? 'Consultant Services' : 'Servicios de Consultores',
        'subtitle': lang == 'en' ? 'View and compare offers' : 'Visualiza y compara ofertas',
        'icon': Icons.view_list,
        'route': AppRoutes.consultantServices,
      },
      {
        'title': lang == 'en' ? 'Performance Metrics' : 'Métricas de Desempeño',
        'subtitle': lang == 'en' ? 'Review performance' : 'Revisa tu rendimiento',
        'icon': Icons.insights,
        'route': AppRoutes.performanceMetrics,
      },
    ];

    if (_controllers == null) {
      _controllers = List.generate(
        options.length,
            (i) => AnimationController(
          duration: const Duration(milliseconds: 150),
          vsync: this,
          lowerBound: 0.95,
          upperBound: 1.0,
        )..value = 1.0,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == 'en' ? 'Welcome to DebtGo' : 'Bienvenido a DebtGo'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.person),
            onSelected: (value) async {
              if (value == 'logout') {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Text(lang == 'en' ? 'Log out' : 'Cerrar sesión'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: options.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            mainAxisExtent: 160,
          ),
          itemBuilder: (context, index) {
            final item = options[index];
            return ScaleTransition(
              scale: _controllers![index],
              child: GestureDetector(
                onTapDown: (_) => _controllers![index].reverse(),
                onTapUp: (_) {
                  _controllers![index].forward();
                  Navigator.pushNamed(context, item['route']);
                },
                onTapCancel: () => _controllers![index].forward(),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item['icon'], size: 36, color: Colors.indigo),
                        const SizedBox(height: 12),
                        Text(
                          item['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['subtitle'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            backgroundColor: Colors.indigo.shade100,
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.notifications);
            },
            tooltip: 'Notificación de prueba',
            child: const Icon(Icons.notifications),
          ),
          if (_hasNotification)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
              ),
            ),
        ],
      ),
    );
  }
}