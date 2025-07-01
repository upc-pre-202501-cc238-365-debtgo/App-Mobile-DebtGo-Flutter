import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String _userName = 'Usuario';
  late final List<AnimationController> _controllers;

  final List<Map<String, dynamic>> options = [
    {
      'title': 'Perfil',
      'subtitle': 'Tus datos',
      'icon': Icons.person,
      'route': AppRoutes.profile,
    },
    {
      'title': 'Reseñas',
      'subtitle': 'Opiniones de usuarios',
      'icon': Icons.reviews,
      'route': AppRoutes.reviews,
    },
    {
      'title': 'Buscar Consultores',
      'subtitle': 'Filtra por rubro',
      'icon': Icons.search,
      'route': AppRoutes.consultantSearch,
    },
    {
      'title': 'Comparar Servicios',
      'subtitle': 'Compara tus opciones',
      'icon': Icons.compare_arrows,
      'route': AppRoutes.serviceComparison,
    },
    {
      'title': 'Alertas de Fechas',
      'subtitle': 'Reuniones, pagos, vencimientos',
      'icon': Icons.calendar_today,
      'route': AppRoutes.alerts,
    },
    {
      'title': 'Calificar Servicio',
      'subtitle': 'Evalúa tu asesoría',
      'icon': Icons.star_rate,
      'route': AppRoutes.serviceRating,
    },
    {
      'title': 'Cancelar Contrato',
      'subtitle': 'Cancela si no cumple',
      'icon': Icons.cancel_presentation,
      'route': AppRoutes.cancelContract,
    },
    {
      'title': 'Simulador de Pagos',
      'subtitle': 'Cuotas y préstamos',
      'icon': Icons.calculate,
      'route': AppRoutes.paymentSimulator,
    },
    {
      'title': 'Ingresos y Gastos',
      'subtitle': 'Control financiero',
      'icon': Icons.bar_chart,
      'route': AppRoutes.incomeExpense,
    },
    {
      'title': 'Presupuesto',
      'subtitle': 'Planifica tus finanzas',
      'icon': Icons.account_balance_wallet,
      'route': AppRoutes.budgetPlanning,
    },
  ];

  bool _hasNotification = false;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadNotificationStatus();
    _checkPendingNavigation();
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
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido a DebtGo'),
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
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'logout',
                child: Text('Cerrar Sesión'),
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
              scale: _controllers[index],
              child: GestureDetector(
                onTapDown: (_) => _controllers[index].reverse(),
                onTapUp: (_) {
                  _controllers[index].forward();
                  Navigator.pushNamed(context, item['route']);
                },
                onTapCancel: () => _controllers[index].forward(),
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