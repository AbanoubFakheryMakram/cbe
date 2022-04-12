
import 'package:flutter/material.dart';

import '../../../utils/constants/enums/app_them_mode_enum.dart';

abstract class ThemeController {
  ThemeMode getCurrentThemeMode();
  ThemeMode updateAndSaveCurrentTheme(AppThemeMode mode);
  Future<ThemeMode> loadSavedTheme();
}