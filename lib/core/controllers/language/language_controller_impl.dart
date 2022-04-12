
import 'package:flutter/material.dart';
import '/l10n/app_localization.dart';

import '../../base/service_locator.dart';
import '../cache/cache_controller.dart';
import 'language_controller.dart';

class LanguageControllerImpl implements LanguageController {

  LanguageControllerImpl() {
    loadLanguage();
    print('load $_langCode');
  }

  String _langCode = 'ar';

  @override
  String getLangCode() => _langCode;

  @override
  String changeLanguage(String langCode) {
    if(!AppLocalization.supportedLocales.contains(Locale(langCode))) {
      return _langCode;
    }

    _langCode = langCode;
    saveNewLanguage(langCode);
    return _langCode;
  }

  @override
  void saveNewLanguage(String langCode) {
    serviceLocator<CacheController>().saveCurrentLanguage(langCode);
  }

  @override
  Future<String> loadLanguage() async {
    String? langCode = await serviceLocator<CacheController>().loadCurrentLanguage();
    return langCode ?? _langCode;
  }
}