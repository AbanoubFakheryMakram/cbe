
import 'package:cbe/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/device_not_save/device_not_save_page.dart';
import 'core/controllers/settings/settings_controller.dart';
import '/features/users/presentation/pages/users_page.dart';
import 'utils/constants/app_theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'utils/constants/app_sizes.dart';
import 'core/controllers/navigation/navigation_controller.dart';
import 'widgets/custom_scroll_behavior.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     var settings = ref.watch(settingsController);
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      navigatorKey: NavigationController.navigatorKey,
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settings.locale),
      themeMode: settings.themeMode,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, child!),
            breakpoints: AppSizes.breakpoints,
          ),
        );
      },
      home: Scaffold(
        body: Builder(
          builder: (context) {
            if (settings.canRunOnThisDevice) {
              return GestureDetector(
                onTap: () {
                  AppUtils.hideKeyboard(context);
                },
                child: UsersPage(),
              );
            } else {
              return const DeviceNotSafePage();
            }
          },
        ),
      ),
    );
  }
}
