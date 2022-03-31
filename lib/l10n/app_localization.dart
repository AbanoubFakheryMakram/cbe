import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/core/controllers/navigation/navigation_controller.dart';

class AppLocalization {
  static List<Locale> supportedLocales = <Locale>[
    const Locale('en'),
    const Locale('ar'),
  ];

  static AppLocalizations get translation => AppLocalizations.of(context)!;
}
