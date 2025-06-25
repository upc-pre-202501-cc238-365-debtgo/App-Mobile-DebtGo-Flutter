import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          const ListTile(
            leading: Icon(Icons.email),
            title: Text('Correo electrónico'),
            subtitle: Text('usuario@correo.com'),
          ),
          const ListTile(
            leading: Icon(Icons.phone),
            title: Text('Teléfono'),
            subtitle: Text('+51 987 654 321'),
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