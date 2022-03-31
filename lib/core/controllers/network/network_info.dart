import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

///
/// [NetworkInfoController] interface is responsible for checking whether the device is connected to the Internet or not
///

abstract class NetworkInfoController {
  Future<bool> get isConnected;
}

class NetworkInfoControllerImpl implements NetworkInfoController {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoControllerImpl(
    this.connectionChecker,
  );

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
