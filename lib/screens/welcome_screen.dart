import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes/app_routes.dart';
import '../services/language_service.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _showLanguageDialog(BuildContext context) {
    final langService = Provider.of<LanguageService>(context, listen: false);
    final currentLang = langService.locale.languageCode;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Selecciona el idioma'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Español'),
              value: 'es',
              groupValue: currentLang,
              onChanged: (value) {
                langService.changeLanguage(value!);
                Navigator.pop(ctx);
              },
            ),
            RadioListTile<String>(
              title: const Text('Inglés'),
              value: 'en',
              groupValue: currentLang,
              onChanged: (value) {
                langService.changeLanguage(value!);
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).locale.languageCode;

    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("lib/assets/images/debtgo-logo.png", height: 120),
              const SizedBox(height: 24),
              Text(
                'DebtGo',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                lang == 'en'
                    ? 'Your ally to manage debts and achieve financial freedom.'
                    : 'Tu aliado para controlar tus deudas y alcanzar la libertad financiera.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: Text(lang == 'en' ? 'Log in' : 'Iniciar sesión'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.indigo,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.person_add_alt),
                label: Text(lang == 'en' ? 'Register' : 'Registrarme'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  foregroundColor: Colors.indigo,
                  side: const BorderSide(color: Colors.indigo),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                },
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                icon: const Icon(Icons.language, color: Colors.indigo),
                label: const Text(
                  'Cambiar idioma',
                  style: TextStyle(color: Colors.indigo),
                ),
                onPressed: () => _showLanguageDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showLanguageDialog(BuildContext context) {
  final langService = Provider.of<LanguageService>(context, listen: false);
  final currentLang = langService.locale.languageCode;

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Selecciona el idioma'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            title: const Text('Español'),
            value: 'es',
            groupValue: currentLang,
            onChanged: (value) {
              langService.changeLanguage(value!);
              Navigator.pop(ctx);
            },
          ),
          RadioListTile<String>(
            title: const Text('Inglés'),
            value: 'en',
            groupValue: currentLang,
            onChanged: (value) {
              langService.changeLanguage(value!);
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    ),
  );
}
