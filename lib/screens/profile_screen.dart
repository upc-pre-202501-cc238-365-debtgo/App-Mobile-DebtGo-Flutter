import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';
import '../services/language_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _email = '';
  String _phone = '';
  String _name = 'Nombre de usuario';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? 'usuario@correo.com';
    final name = prefs.getString('name') ?? 'Nombre de usuario';
    var phone = prefs.getString('phone');

    if (phone == null) {
      final random = Random();
      phone = '+51 9${1000000 + random.nextInt(8999999)}';
      await prefs.setString('phone', phone);
    }

    setState(() {
      _email = email;
      _name = name;
      _phone = phone!;
    });
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
      appBar: AppBar(title: Text(lang == 'en' ? 'My Profile' : 'Mi Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.indigo,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          Center(child: Text(_name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const Divider(height: 40),
          ListTile(
            leading: const Icon(Icons.email),
            title: Text(lang == 'en' ? 'Email' : 'Correo electrónico'),
            subtitle: Text(_email),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: Text(lang == 'en' ? 'Phone' : 'Teléfono'),
            subtitle: Text(_phone),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(lang == 'en' ? 'Settings' : 'Configuración'),
            subtitle: Text(lang == 'en' ? 'Notifications, privacy, language' : 'Notificaciones, privacidad, idioma'),
            onTap: () {
              // futura funcionalidad
            },
          ),
          const Divider(height: 40),
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
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.editableProfile),
            icon: const Icon(Icons.edit),
            label: Text(lang == 'en' ? 'Edit profile' : 'Editar perfil'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              foregroundColor: Colors.indigo,
            ),
          ),
        ],
      ),
    );
  }
}