import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';
import '../services/notification_service.dart';

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
      'title': 'Emprendedores',
      'subtitle': 'Recursos y ayuda',
      'icon': Icons.business,
      'route': AppRoutes.entrepreneurs,
    },
    {
      'title': 'Gestión de Deudas',
      'subtitle': 'Vencimientos y pagos',
      'icon': Icons.account_balance_wallet,
      'route': AppRoutes.debtManagement,
    },
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
      'title': 'Mensajes',
      'subtitle': 'Consulta con asesor',
      'icon': Icons.chat,
      'route': AppRoutes.messages,
    },
    {
      'title': 'Planes y suscripción',
      'subtitle': 'Elige tu plan',
      'icon': Icons.workspace_premium,
      'route': AppRoutes.planSelection,
    },
    {
      'title': 'Registrar Deuda',
      'subtitle': 'Añadir nueva',
      'icon': Icons.add,
      'route': AppRoutes.addDebt,
    },
    {
      'title': 'Historial de Pagos',
      'subtitle': 'Tus registros',
      'icon': Icons.history,
      'route': AppRoutes.paymentHistory,
    },
  ];

  bool _hasNotification = false;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadNotificationStatus();
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