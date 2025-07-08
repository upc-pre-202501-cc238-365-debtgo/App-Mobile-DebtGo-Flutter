import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  Locale _locale = const Locale('es');

  LanguageService(Locale locale) {
    _loadLocale();
  }

  Locale get locale => _locale;

  String get language => _locale.languageCode;

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('language') ?? 'es';
    _locale = Locale(langCode);
    notifyListeners();
  }

  Future<void> changeLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', langCode);
    _locale = Locale(langCode);
    notifyListeners();
  }
}
