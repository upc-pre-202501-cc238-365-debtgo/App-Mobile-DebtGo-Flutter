import 'package:debtgo_flutter/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'routes/app_routes.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_PE', null);
  await NotificationService.init();
  runApp(const DebtGoApp());
}

class DebtGoApp extends StatelessWidget {
  const DebtGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DebtGo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes
    );
  }
}

