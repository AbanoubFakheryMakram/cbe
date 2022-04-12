
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../controllers/http/http_controller.dart';
import '../controllers/language/language_controller.dart';
import '../controllers/network/network_info_controller.dart';
import '../controllers/theme/theme_controller.dart';
import '/core/controllers/encryption/encryption_controller_impl.dart';
import '/core/controllers/exector/executor.dart';
import '/core/controllers/exector/executor_impl.dart';
import '../controllers/encryption/encryption_controller.dart';
import '/core/controllers/device/safe_device_controller.dart';
import '/core/controllers/device/safe_device_controller_impl.dart';
import '/core/controllers/biometric/biometric_controller.dart';
import '/core/controllers/biometric/biometric_scontroller_impl.dart';
import '/core/controllers/permissions/permissions_contoller.dart';
import '/core/controllers/permissions/permissions_controller_impl.dart';
import '../controllers/network/network_info.dart';
import '/core/controllers/files/file_controller.dart';
import '/core/controllers/files/file_controller_impl.dart';
import '/core/controllers/dialogs/dialog_controller.dart';
import '/core/controllers/dialogs/dialog_impl_controller.dart';
import '/features/users/data/repo_impl/users_repo_impl.dart';
import '/features/users/domain/repo/users_repo.dart';
import '/features/users/domain/use_cases/users_usercase.dart';
import '../controllers/language/language_controller_impl.dart';
import '../../core/controllers/navigation/navigation_controller.dart';
import '../controllers/theme/theme_controller_impl.dart';

import '../controllers/navigation/navigation_controller_impl.dart';
import '../controllers/settings/settings_controller.dart';
import '../controllers/cache/cache_controller.dart';
import '../controllers/http/http_controller_impl.dart';

// service locator
final serviceLocator = GetIt.instance;

Future<void> initDI() async {

  // general
  serviceLocator.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true)));
  serviceLocator.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());
  serviceLocator.registerLazySingleton<NetworkInfoController>(() => NetworkInfoControllerImpl(serviceLocator()));
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  serviceLocator.registerLazySingleton<AwesomeNotifications>(() => AwesomeNotifications());
  serviceLocator.registerLazySingleton<ActionExecutor>(() => ActionExecutorImpl(connectivityService: serviceLocator(), dialogService: serviceLocator(), navigationService: serviceLocator()));

  // controllers
  serviceLocator.registerLazySingleton<CacheController>(() => CacheController(serviceLocator()));
  serviceLocator.registerLazySingleton<SettingsController>(() => SettingsController());
  serviceLocator.registerLazySingleton<ThemeController>(() => ThemeControllerImpl());
  serviceLocator.registerLazySingleton<LanguageController>(() => LanguageControllerImpl());
  serviceLocator.registerLazySingleton<DialogController>(() => DialogImplController());
  serviceLocator.registerLazySingleton<FilesController>(() => FilesControllerImpl());
  serviceLocator.registerLazySingleton<BiometricController>(() => BiometricControllerImpl());
  serviceLocator.registerLazySingleton<PermissionController>(() => PermissionControllerImpl());
  serviceLocator.registerLazySingleton<HttpController>(() => HttpControllerImpl());
  serviceLocator.registerLazySingleton<NavigationController>(() => NavigationControllerImpl());
  serviceLocator.registerLazySingleton<SafeDeviceController>(() => SafeDeviceControllerImpl());
  serviceLocator.registerLazySingleton<EncryptionController>(() => EncryptionControllerImpl());

  // repo and repo impl
  serviceLocator.registerLazySingleton<UsersRepo>(() => UsersRepoImpl(serviceLocator()));

  // usecase
  serviceLocator.registerLazySingleton<UsersUsecase>(() => UsersUsecase(serviceLocator()));
}