
abstract class SafeDeviceController {
  Future<bool> isRealDevice();
  Future<bool> isSafeDevice();
  Future<bool> isDeviceJailbroken();
  Future<bool> canRunTheAppOnThisDevice();
}