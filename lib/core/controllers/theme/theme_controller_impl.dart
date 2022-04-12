import 'package:flutter/material.dart';
import '/core/base/service_locator.dart';
import '/core/controllers/cache/cache_controller.dart';

import '../../../utils/constants/enums/app_them_mode_enum.dart';
import 'theme_controller.dart';

class ThemeControllerImpl implements ThemeController {

  ThemeControllerImpl() {
    loadSavedTheme();
  }

  ThemeMode _currentThemeMode = ThemeMode.system;  // for first time launch default theme will be system theme

  @override
  ThemeMode updateAndSaveCurrentTheme(AppThemeMode mode) {
    switch(mode) {
      case AppThemeMode.LIGHT:
        _currentThemeMode = ThemeMode.light;
        break;
      case AppThemeMode.DARK:
        _currentThemeMode = ThemeMode.dark;
        break;
      case AppThemeMode.SYSTEM:
        _currentThemeMode = ThemeMode.system;
        break;
    }

    _saveTheme(mode);
    return _currentThemeMode;
  }

  void _saveTheme(AppThemeMode mode) {
    var storageController = serviceLocator<CacheController>();
    switch (mode) {
      case AppThemeMode.LIGHT:
        storageController.saveCurrentTheme(AppThemeMode.LIGHT.name);
        break;
      case AppThemeMode.DARK:
        storageController.saveCurrentTheme(AppThemeMode.DARK.name);
        break;
      case AppThemeMode.SYSTEM:
        storageController.saveCurrentTheme(AppThemeMode.SYSTEM.name);
        break;
    }
  }

  @override
  Future<ThemeMode> loadSavedTheme() async {
    String? themeName = await serviceLocator<CacheController>().loadCurrentTheme();
    return _getTheme(themeName);
  }

  ThemeMode _getTheme(String? themeName) {
    switch (themeName) {
      case 'LIGHT':
        _currentThemeMode = ThemeMode.light;
        return _currentThemeMode;
      case 'DARK':
        _currentThemeMode = ThemeMode.dark;
        return _currentThemeMode;
      default:
        return _currentThemeMode = ThemeMode.system;
    }
  }

  @override
  ThemeMode getCurrentThemeMode() {
    return _currentThemeMode;
  }
}

