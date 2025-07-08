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
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  int _currentIndex = 0;
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _fadeController.forward();

    SharedPreferences.getInstance().then((prefs) => prefs.remove('acceptedTerms'));

    _loadUserName();
    _checkPendingNavigation();
    _checkTermsAcceptance();
    _loadNotificationStatus();
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

  Future<void> _checkTermsAcceptance() async {
    final prefs = await SharedPreferences.getInstance();
    final hasAccepted = prefs.getBool('acceptedTerms') ?? false;

    if (!hasAccepted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showTermsAndConditions(context, prefs);
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
      _unreadCount = prefs.getInt('unreadCount') ?? 0;
    });
    print('🔴 Unread Count: $_unreadCount');
  }

  @override
  void dispose() {
    _fadeController.dispose();
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

    final greeting = lang == 'en' ? 'Hello, $_userName!' : 'Hola, $_userName!';

    final List<Map<String, dynamic>> options = [
      {
        'title': lang == 'en' ? 'Reviews' : 'Reseñas',
        'subtitle': lang == 'en' ? 'User feedback' : 'Opiniones de usuarios',
        'icon': Icons.reviews,
        'route': AppRoutes.reviews,
      },
      {
        'title': lang == 'en' ? 'Find Entrepreneurs' : 'Buscar Emprendedores',
        'subtitle': lang == 'en' ? 'Filter by sector' : 'Filtra por rubro',
        'icon': Icons.search,
        'route': AppRoutes.entrepreneurSearch,
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
        'title': lang == 'en' ? 'Cancel Contract' : 'Cancelar Contrato de Asesores',
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
        'title': lang == 'en' ? 'Accept Request' : 'Aceptar Solicitud de Asesores',
        'subtitle': lang == 'en' ? 'Manage pending' : 'Gestiona solicitudes pendientes',
        'icon': Icons.how_to_reg,
        'route': AppRoutes.acceptRequest,
      },
      {
        'title': lang == 'en' ? 'Consultant Services' : 'Servicios de Asesores',
        'subtitle': lang == 'en' ? 'View and compare offers' : 'Visualiza y compara ofertas',
        'icon': Icons.view_list,
        'route': AppRoutes.entrepreneurServices,
      },
      {
        'title': lang == 'en' ? 'Performance Metrics' : 'Métricas de Desempeño',
        'subtitle': lang == 'en' ? 'Review performance' : 'Revisa tu rendimiento',
        'icon': Icons.insights,
        'route': AppRoutes.performanceMetrics,
      },
      {
        'title': lang == 'en' ? 'My Requests' : 'Mis Solicitudes',
        'subtitle': lang == 'en' ? 'Your advisor history' : 'Historial de asesorías',
        'icon': Icons.history,
        'route': AppRoutes.adviceRequestListScreen,
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          greeting,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                tooltip: lang == 'es' ? 'Notificaciones' : 'Notifications',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.notifications);
                },
              ),
              if (_hasNotification && _unreadCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Center(
                      child: Text(
                        '$_unreadCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.article_outlined),
            tooltip: lang == 'es' ? 'Términos y Condiciones' : 'Terms and Conditions',
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              _showTermsAndConditions(context, prefs);
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF5F7FA), Color(0xFFDDE6ED)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
            child: GridView.builder(
              padding: const EdgeInsets.only(top: 16),
              itemCount: options.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                mainAxisExtent: 190,
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 6,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.indigo.shade100,
                              child: Icon(item['icon'], size: 28, color: Colors.indigo),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['subtitle'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12, color: Colors.black54),
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
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          if (index == 0) {
            // Ya estamos en Home
          } else if (index == 1) {
            Navigator.pushNamed(context, AppRoutes.profile);
          } else if (index == 2) {
            Navigator.pushNamed(context, AppRoutes.startRequest);
          }
        },
        selectedItemColor: Colors.indigo,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: lang == 'en' ? 'Home' : 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: lang == 'en' ? 'Profile' : 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: lang == 'en' ? 'Consult' : 'Asesoría'),
        ],
      ),
    );
  }
}

void _showTermsAndConditions(BuildContext context, SharedPreferences prefs) {
  final lang = Provider.of<LanguageService>(context, listen: false).locale.languageCode;
  bool isAccepted = false;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text(
            lang == 'es' ? 'Términos y Condiciones' : 'Terms and Conditions',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    lang == 'es'
                        ? 'Al utilizar DebtGo, aceptas cumplir con nuestras políticas de uso. No está permitido compartir información falsa o realizar acciones que atenten contra la seguridad de los usuarios. Tus datos están protegidos bajo nuestra política de privacidad. Para más información, revisa nuestra web oficial.'
                        : 'By using DebtGo, you agree to comply with our usage policies. It is not allowed to share false information or take actions that compromise user safety. Your data is protected under our privacy policy. For more details, please visit our official website.',
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: isAccepted,
                        onChanged: (value) {
                          setState(() {
                            isAccepted = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          lang == 'es'
                              ? 'He leído y acepto los términos.'
                              : 'I have read and accept the terms.',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: isAccepted
                  ? () async {
                await prefs.setBool('acceptedTerms', true);
                Navigator.of(context).pop();
              }
                  : null,
              child: Text(
                lang == 'es' ? 'Cerrar' : 'Close',
                style: TextStyle(
                  color: isAccepted ? Colors.indigo : Colors.grey,
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        );
      });
    },
  );
}
