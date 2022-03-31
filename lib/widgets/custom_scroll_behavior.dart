
import 'package:flutter/material.dart';

/// [CustomScrollBehavior] is a class for removing the animation for over-scrolling in Android platform
class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

BouncingScrollPhysics bouncingScrollPhysics = const BouncingScrollPhysics();
ClampingScrollPhysics clampingScrollPhysics = const ClampingScrollPhysics();