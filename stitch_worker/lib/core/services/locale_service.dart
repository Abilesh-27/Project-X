import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Supported app locales — matches ARB file set.
class AppLocales {
  AppLocales._();

  static const Locale english = Locale('en');
  static const Locale hindi = Locale('hi');
  static const Locale tamil = Locale('ta');
  static const Locale malayalam = Locale('ml');

  static const List<Locale> supported = [english, hindi, tamil, malayalam];

  /// Display names for the language selector UI.
  static const Map<String, String> displayNames = {
    'en': 'English',
    'hi': 'हिन्दी',
    'ta': 'தமிழ்',
    'ml': 'മലയാളം',
  };

  /// Subtitle descriptions for language cards.
  static const Map<String, String> subtitles = {
    'en': 'English',
    'hi': 'Hindi',
    'ta': 'Tamil',
    'ml': 'Malayalam',
  };
}

/// ChangeNotifier that manages the current locale.
/// Persists the selected language to SharedPreferences.
/// Rebuilds the entire app tree when locale changes.
class LocaleProvider extends ChangeNotifier {
  static const String _prefKey = 'selected_locale';

  Locale _locale = AppLocales.english;
  Locale get locale => _locale;

  /// Load persisted locale from SharedPreferences.
  /// Call this once at app startup before runApp.
  Future<void> loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_prefKey);
      if (saved != null && AppLocales.supported.any((l) => l.languageCode == saved)) {
        _locale = Locale(saved);
        notifyListeners();
      }
    } catch (_) {
      // Ignored if SharedPreferences is unavailable in test environment
    }
  }

  /// Change locale and persist it.
  /// The entire MaterialApp rebuilds immediately via ChangeNotifier.
  Future<void> setLocale(Locale newLocale) async {
    if (_locale == newLocale) return;
    _locale = newLocale;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, newLocale.languageCode);
    } catch (_) {
      // Ignored if SharedPreferences is unavailable in test environment
    }
  }
}
