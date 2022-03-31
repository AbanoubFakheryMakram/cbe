
import 'package:flutter/material.dart';
import '/l10n/app_localization.dart';

import '../../base/service_locator.dart';
import '../cache/cache_controller.dart';

class LanguageController {

  LanguageController() {
    loadLanguage();
    print('load $_langCode');
  }

  String _langCode = 'ar';

  String get langCode => _langCode;

  String changeLanguage(String langCode) {
    if(!AppLocalization.supportedLocales.contains(Locale(langCode))) {
      return _langCode;
    }

    _langCode = langCode;
    saveNewLanguage(langCode);
    return _langCode;
  }

  void saveNewLanguage(String langCode) {
    serviceLocator<CacheController>().saveCurrentLanguage(langCode);
  }

  Future<String> loadLanguage() async {
    String? langCode = await serviceLocator<CacheController>().loadCurrentLanguage();
    switch(langCode) {
      case 'en':
        _langCode = 'en';
        return _langCode;
      case 'ar':
        _langCode = 'ar';
        return _langCode;
      default:
        _langCode = 'ar';  // default language is arabic
        return _langCode;
    }
  }
}