import 'package:debtgo_flutter/provider/advice_request_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:debtgo_flutter/services/notification_service.dart';
import 'package:debtgo_flutter/services/language_service.dart';
import 'core/theme.dart';
import 'routes/app_routes.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_PE', null);
  await NotificationService.init();

  final prefs = await SharedPreferences.getInstance();
  final savedLang = prefs.getString('lang') ?? 'es';

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdviceRequestProvider()),
        ChangeNotifierProvider(create: (_) => LanguageService(Locale(savedLang))),
      ],
      child: const DebtGoApp(),
    ),
  );
}

class DebtGoApp extends StatelessWidget {
  const DebtGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final langService = Provider.of<LanguageService>(context);

    return MaterialApp(
      title: 'DebtGo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      locale: langService.locale,
      supportedLocales: const [
        Locale('es', ''),
        Locale('en', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}