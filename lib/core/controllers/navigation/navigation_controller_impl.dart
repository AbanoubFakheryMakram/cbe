
import 'package:flutter/material.dart';

import 'navigation_controller.dart';

class NavigationControllerImpl implements NavigationController {
  final _navigatorKey = NavigationController.navigatorKey;

  @override
  void pop<T>({T? data}) {
    if (Navigator.canPop(_navigatorKey.currentContext!)) {
      _navigatorKey.currentState!.pop(data);
    }
  }

  /// pushes the page to the top of the stack
  @override
  Future<T?> push<T>(Widget page) {
    return WidgetsBinding.instance!.waitUntilFirstFrameRasterized.then((value) {
      return _navigatorKey.currentState!.push(MaterialPageRoute<T>(builder: (context) => page));
    });
  }

  /// removes the current page from the navigation stack and push sended page in stack
  @override
  Future<T?> pushReplacement<T>(Widget page) {
    return WidgetsBinding.instance!.waitUntilFirstFrameRasterized.then((value) {
      return _navigatorKey.currentState!.pushReplacement(MaterialPageRoute<T>(builder: (context) => page));
    });
  }

  /// removes all pages on the stack and pushes the page to it
  @override
  Future<T?> setRootPage<T>(Widget page) {
    return WidgetsBinding.instance!.waitUntilFirstFrameRasterized.then((value) {
      return _navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => page), (Route<dynamic> route) => false);
    });
  }
}