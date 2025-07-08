import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';
import '../services/language_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  Future<void> _setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang);
    Provider.of<LanguageService>(context, listen: false).changeLanguage(lang);
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = '+51 9${1000000 + Random().nextInt(8999999)}';

    await prefs.setBool('is_logged', true);
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);

    if (!mounted) return;
    setState(() => _loading = false);
    final lang = Provider.of<LanguageService>(context, listen: false).locale.languageCode;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(lang == 'en' ? 'Successful registration!' : 'Registro exitoso. ¡Bienvenido a DebtGo!')),
    );
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context).locale.languageCode;

    return Scaffold(
      appBar: AppBar(title: Text(lang == 'en' ? 'Create Account' : 'Crear cuenta')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.person_add_alt_1, size: 80, color: Colors.indigo),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: lang == 'en' ? 'Full Name' : 'Nombre completo',
                  prefixIcon: const Icon(Icons.person),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? (lang == 'en' ? 'Enter your full name' : 'Ingrese su nombre completo')
                    : null,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: lang == 'en' ? 'Email' : 'Correo electrónico',
                  prefixIcon: const Icon(Icons.email),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return lang == 'en' ? 'Enter your email' : 'Ingrese su correo';
                  }
                  final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                  return regex.hasMatch(value.trim())
                      ? null
                      : (lang == 'en' ? 'Invalid email' : 'Correo no válido');
                },
                keyboardType: TextInputType.emailAddress,
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return lang == 'en' ? 'Enter a password' : 'Ingrese una contraseña';
                  }
                  return value.trim().length < 8
                      ? (lang == 'en'
                      ? 'Must be at least 8 characters'
                      : 'Debe tener al menos 8 caracteres')
                      : null;
                },
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _loading ? null : _register,
                  icon: _loading
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Icon(Icons.check),
                  label: Text(lang == 'en' ? 'Register' : 'Registrarme'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
