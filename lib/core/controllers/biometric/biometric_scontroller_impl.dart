import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'biometric_controller.dart';

class BiometricControllerImpl implements BiometricController {

  BiometricControllerImpl() {
    _init();
  }

  bool _initialized = false;
  final _localAuth = LocalAuthentication();
  late List<BiometricMethod> _availableBiometrics;

  Future<void> _init() async {
    if (_initialized) return;
    var availableBiometrics = await _localAuth.getAvailableBiometrics();
    _availableBiometrics = availableBiometrics.map((e) => BiometricMethod.mapFromEnumValue(e)).toList();
    _initialized = true;
  }

  @override
  Future<bool> get isBiometricsAvailable async {
    await _init();
    return _localAuth.canCheckBiometrics;
  }

  @override
  Future<List<BiometricMethod>> get availableBiometrics async {
    await _init();
    return Future.value(_availableBiometrics);
  }

  @override
  Future<bool> get isFaceRecognitionAvailable async {
    var biometrics = await availableBiometrics;
    return biometrics.any((element) => element == BiometricMethod.face);
  }

  @override
  Future<bool> get isFingerPrintAvailable async {
    var biometrics = await availableBiometrics;
    return biometrics.any((element) => element == BiometricMethod.fingerprint);
  }

  @override
  Future<bool> requestAuthenticate({
    required String localizedMessage,
    bool backgroundAuth = false,
    bool useErrorDialogs = true,
    AndroidAuthMessages androidAuthStrings = const AndroidAuthMessages(),
    IOSAuthMessages iOSAuthStrings = const IOSAuthMessages(),
    bool sensitiveTransaction = true,
    bool biometricOnly = false,
  }) => _localAuth.authenticate(
        localizedReason: localizedMessage,
        stickyAuth: backgroundAuth,
        useErrorDialogs: useErrorDialogs,
        androidAuthStrings: androidAuthStrings,
        iOSAuthStrings: iOSAuthStrings,
        sensitiveTransaction: sensitiveTransaction,
        biometricOnly: biometricOnly,
      );

  @override
  void stopAuthentication() {
    _localAuth.stopAuthentication();
  }
}
