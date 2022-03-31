
import 'package:flutter/material.dart';

abstract class NavigationController {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => NavigationController.navigatorKey.currentContext!;

  void pop<T>({T? data});

  Future<T?> push<T>(Widget page);

  Future<T?> pushReplacement<T>(Widget page);

  Future<T?> setRootPage<T>(Widget page);
}

BuildContext get context => NavigationController.context;
