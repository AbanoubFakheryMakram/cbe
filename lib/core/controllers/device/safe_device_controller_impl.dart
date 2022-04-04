
import 'package:flutter/foundation.dart';
import 'package:safe_device/safe_device.dart';

import 'safe_device_controller.dart';

class SafeDeviceControllerImpl implements SafeDeviceController {

  @override
  Future<bool> isDeviceJailbroken() async {
    return await SafeDevice.isJailBroken;
  }

  @override
  Future<bool> isSafeDevice() async {
    // is not rooted
    return (await SafeDevice.isSafeDevice);
  }

  @override
  Future<bool> isRealDevice() async {
    return await SafeDevice.isRealDevice;
  }

  @override
  Future<bool> canRunTheAppOnThisDevice() async {
    if (!kReleaseMode) {
      return (!await isDeviceJailbroken());
    } else {
      return (!await isDeviceJailbroken()) &&
          (await isSafeDevice()) &&
          (await isRealDevice());
    }
  }
}