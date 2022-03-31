import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/controllers/device/safe_device_controller.dart';
import '/utils/constants/enums/app_them_mode_enum.dart';

import '../theme/theme_controller.dart';
import '../../base/service_locator.dart';
import '../language/language_controller.dart';

final settingsController = ChangeNotifierProvider((_) => serviceLocator<SettingsController>());

class SettingsController with ChangeNotifier {

  SettingsController() {
    loadSettings();
  }

  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  late String _locale;

  String get locale => _locale;

  late bool _canRunOnThisDevice;

  bool get canRunOnThisDevice => _canRunOnThisDevice;

  Future<void> loadSettings() async {
    // can run on this device
    _canRunOnThisDevice = await serviceLocator<SafeDeviceController>().canRunTheAppOnThisDevice();

    // load theme
    _themeMode = serviceLocator<ThemeController>().currentThemeMode;

    // load system locale
    _locale = serviceLocator<LanguageController>().langCode;

    await initWebViewConfiguration();

    notifyListeners();
  }

  void changeTheme(AppThemeMode mode) {
    _themeMode = serviceLocator<ThemeController>().updateAndSaveCurrentTheme(mode);
    notifyListeners();
  }

  void changeLanguage(String langCode) {
    _locale = serviceLocator<LanguageController>().changeLanguage(langCode);
    notifyListeners();
  }

  Future<void> initWebViewConfiguration() async {
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
      var swAvailable = await AndroidWebViewFeature.isFeatureSupported(AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);
      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController = AndroidServiceWorkerController.instance();
        serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            print(request);
            return null;
          },
        );
      }
    }
  }
}