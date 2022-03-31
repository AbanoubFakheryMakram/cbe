// base class to provide biometric service available and ask user to verify himself by biometric login

//depends on local_auth: ^1.1.8,   equatable: ^2.0.3
import 'package:equatable/equatable.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

abstract class BiometricController {
  /// check if device contains any biometrics
  Future<bool> get isBiometricsAvailable;

  /// get list of available biometrics
  Future<List<BiometricMethod>> get availableBiometrics;

  ///define if fingerprint available
  Future<bool> get isFingerPrintAvailable;

  ///define if login by face available
  Future<bool> get isFaceRecognitionAvailable;

  /// request authentication
  /// [backgroundAuth] is used when the application goes into background for any
  /// reason while the authentication is in progress. Due to security reasons,
  /// the authentication has to be stopped at that time. If stickyAuth is set
  /// to true, authentication resumes when the app is resumed. If it is set to
  /// false (default), then as soon as app is paused a failure message is sent
  /// back to Dart and it is up to the client app to restart authentication or
  /// do something else.
  /// [useErrorDialogs] = true means the system will attempt to handle user
  /// fixable issues encountered while authenticating. For instance, if
  /// fingerprint reader exists on the phone but there's no fingerprint
  /// registered, the plugin will attempt to take the user to settings to add
  /// one. Anything that is not user fixable, such as no biometric sensor on
  /// device, will be returned as a [PlatformException].
  ///
  Future<bool> requestAuthenticate({
    required String localizedMessage,
    bool backgroundAuth = false,
    bool useErrorDialogs = true,
    AndroidAuthMessages androidAuthStrings = const AndroidAuthMessages(),
    IOSAuthMessages iOSAuthStrings = const IOSAuthMessages(),
    bool sensitiveTransaction = true,
    bool biometricOnly = false,
  });

  /// stop process of Authentication
  void stopAuthentication();
}

class BiometricMethod extends Equatable {
  final String _value;
  const BiometricMethod._(this._value);

  static const BiometricMethod face = BiometricMethod._('face');
  static const BiometricMethod fingerprint = BiometricMethod._('fingerprint');
  static const BiometricMethod iris = BiometricMethod._('iris');
  static const BiometricMethod none = BiometricMethod._('none');

    factory BiometricMethod.mapFromEnumValue(BiometricType value) {
    switch (value) {
      case BiometricType.face:
        return face;
      case BiometricType.fingerprint:
        return fingerprint;
      case BiometricType.iris:
        return iris;
      default:
        return none;
    }
  }

  @override
  List<Object?> get props => [_value];
}
