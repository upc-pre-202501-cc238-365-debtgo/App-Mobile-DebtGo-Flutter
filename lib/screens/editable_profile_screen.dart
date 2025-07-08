import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';
import '../services/language_service.dart';

class EditableProfileScreen extends StatefulWidget {
  const EditableProfileScreen({super.key});

  @override
  State<EditableProfileScreen> createState() => _EditableProfileScreenState();
}

class _EditableProfileScreenState extends State<EditableProfileScreen> {
  late Future<Map<String, String>> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _loadProfile();
  }

  Future<Map<String, String>> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString('email') ?? 'usuario@correo.com',
      'phone': prefs.getString('phone') ?? '+51 987 654 321',
    };
  }

  Future<void> _changeLanguage(BuildContext context) async {
    final langService = Provider.of<LanguageService>(context, listen: false);
    final currentLanguage = langService.locale.languageCode;

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
              groupValue: currentLanguage,
              onChanged: (value) {
                langService.changeLanguage(value!);
                Navigator.pop(ctx);
              },
            ),
            RadioListTile<String>(
              title: const Text('Inglés'),
              value: 'en',
              groupValue: currentLanguage,
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

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).locale.languageCode;

    return Scaffold(
      appBar: AppBar(title: Text(lang == 'en' ? 'Edit Profile' : 'Editar Perfil')),
      body: FutureBuilder<Map<String, String>>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          final email = data['email']!;
          final phone = data['phone']!;

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.indigo,
                  child: Icon(Icons.person, size: 45, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                lang == 'en' ? 'Registered Information' : 'Información registrada',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.email, color: Colors.indigo),
                  title: Text(lang == 'en' ? 'Email' : 'Correo electrónico'),
                  subtitle: Text(email),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.phone, color: Colors.indigo),
                  title: Text(lang == 'en' ? 'Phone' : 'Teléfono'),
                  subtitle: Text(phone),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.settings, color: Colors.indigo),
                  title: Text(lang == 'en' ? 'Settings' : 'Configuración'),
                  subtitle: Text(lang == 'en'
                      ? 'Notifications, privacy, language'
                      : 'Notificaciones, privacidad, idioma'),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout),
                label: Text(lang == 'en' ? 'Log out' : 'Cerrar sesión'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}