import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _email = 'usuario@correo.com';
  String _phone = '+51 987 654 321';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    final email = prefs.getString('email') ?? 'usuario@correo.com';
    var phone = prefs.getString('phone');

    // Si no hay un teléfono guardado, genera uno aleatorio
    if (phone == null) {
      final random = Random();
      phone = '+51 9${1000000 + random.nextInt(8999999)}';
      await prefs.setString('phone', phone);
    }

    setState(() {
      _email = email;
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
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 45,
              child: Icon(Icons.person, size: 45),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Correo electrónico'),
            subtitle: Text(_email),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Teléfono'),
            subtitle: Text(_phone),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            subtitle: Text('Notificaciones, privacidad, idioma'),
          ),
          const Divider(),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
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
            label: const Text('Editar perfil'),
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