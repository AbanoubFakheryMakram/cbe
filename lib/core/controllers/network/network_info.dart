import 'dart:async';

abstract class NetworkInfoController {
  Future<bool> get isConnected;
}
