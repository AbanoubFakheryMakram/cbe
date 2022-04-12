import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'network_info.dart';

class NetworkInfoControllerImpl implements NetworkInfoController {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoControllerImpl(
      this.connectionChecker,
      );

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}