import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/controllers/settings/settings_controller.dart';

import 'app.dart';
import 'core/base/service_locator.dart';

void main() async {
  await runZonedGuarded(
    () async {

      WidgetsFlutterBinding.ensureInitialized();
      await initDI();

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      SettingsController settingsController = serviceLocator<SettingsController>();
      await settingsController.loadSettings();

      runApp(const ProviderScope(child: MyApp()));
    },
    (error, stacktrace) {
      print('error: $error\n stacktrace: $stacktrace');
    },
  );
}
