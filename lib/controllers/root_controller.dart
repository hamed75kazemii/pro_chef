import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'recipe_controller.dart';

class RootController extends GetxController {
  static RootController get to => Get.find();

  final _storage = GetStorage();
  final _languageKey = 'app_language';
  final _themeKey = 'app_theme';

  // Observable variables
  final _currentLanguage = 'en'.obs;
  final _currentTheme = ThemeMode.light.obs;
  final _isDarkMode = false.obs;

  // Getters
  String get currentLanguage => _currentLanguage.value;
  ThemeMode get currentTheme => _currentTheme.value;
  bool get isDarkMode => _isDarkMode.value;
  Locale get currentLocale => Locale(_currentLanguage.value);

  @override
  void onInit() {
    super.onInit();
    _loadSavedSettings();
  }

  void _loadSavedSettings() {
    // Load saved language
    final savedLanguage = _storage.read(_languageKey) ?? 'en';
    _currentLanguage.value = savedLanguage;

    // Load saved theme
    final savedTheme = _storage.read(_themeKey) ?? 'light';
    _isDarkMode.value = savedTheme == 'dark';
    _currentTheme.value = _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  }

  void switchLanguage() {
    final newLanguage = _currentLanguage.value == 'en' ? 'fa' : 'en';
    _currentLanguage.value = newLanguage;
    _storage.write(_languageKey, newLanguage);

    // Update app locale
    Get.updateLocale(Locale(newLanguage));

    // Update recipe controller filter translation
    try {
      final recipeController = Get.find<RecipeController>();
      recipeController.updateSelectedFilterTranslation();
    } catch (e) {
      // Recipe controller might not be initialized yet
    }
  }

  void setLanguage(String languageCode) {
    if (languageCode != _currentLanguage.value) {
      _currentLanguage.value = languageCode;
      _storage.write(_languageKey, languageCode);
      Get.updateLocale(Locale(languageCode));

      // Update recipe controller filter translation
      try {
        final recipeController = Get.find<RecipeController>();
        recipeController.updateSelectedFilterTranslation();
      } catch (e) {
        // Recipe controller might not be initialized yet
      }
    }
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    _currentTheme.value = _isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
    _storage.write(_themeKey, _isDarkMode.value ? 'dark' : 'light');

    // Update app theme
    Get.changeThemeMode(_currentTheme.value);
  }

  void setTheme(ThemeMode themeMode) {
    _currentTheme.value = themeMode;
    _isDarkMode.value = themeMode == ThemeMode.dark;
    _storage.write(_themeKey, _isDarkMode.value ? 'dark' : 'light');
    Get.changeThemeMode(themeMode);
  }

  String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'fa':
        return 'فارسی';
      default:
        return 'English';
    }
  }

  String getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'en':
        return '🇺🇸';
      case 'fa':
        return '🇮🇷';
      default:
        return '🇺🇸';
    }
  }
}
