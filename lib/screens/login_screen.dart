import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';
import '../services/language_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  bool _isLoading = false;

  Future<void> _setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang);
    Provider.of<LanguageService>(context, listen: false).changeLanguage(lang);
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();
    final email = _emailController.text.trim();

    String name = prefs.getString('name') ?? '';
    if (name.isEmpty) {
      if (email.toLowerCase().contains('daniel')) {
        name = 'Daniel';
      } else if (email.toLowerCase().contains('pedro')) {
        name = 'Pedro';
      } else {
        name = email.split('@').first.capitalize();
      }
      await prefs.setString('name', name);
    }

    String? phone = prefs.getString('phone');
    if (phone == null) {
      phone = '+51 9${1000000 + Random().nextInt(8999999)}';
      await prefs.setString('phone', phone);
    }

    await prefs
      ..setBool('is_logged', true)
      ..setString('email', email);

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).locale.languageCode;
    return Scaffold(
      appBar: AppBar(title: Text(lang == 'en' ? 'Sign in' : 'Iniciar sesión')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.lock_outline, size: 80, color: Colors.indigo),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: lang == 'en' ? 'Email' : 'Correo electrónico',
                  prefixIcon: const Icon(Icons.email),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? (lang == 'en' ? 'Required' : 'Campo obligatorio')
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passController,
                obscureText: _obscure,
                decoration: InputDecoration(
                  labelText: lang == 'en' ? 'Password' : 'Contraseña',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                validator: (value) => (value == null || value.length < 8)
                    ? (lang == 'en' ? 'At least 8 characters' : 'Mínimo 8 caracteres')
                    : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : Text(lang == 'en' ? 'Sign in' : 'Ingresar'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                child: Text(lang == 'en'
                    ? "Don't have an account? Register here"
                    : '¿No tienes cuenta? Regístrate aquí'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}