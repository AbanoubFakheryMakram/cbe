
import 'package:flutter/material.dart';

class ResponsivePage extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  ResponsivePage({Key? key, required this.mobile, this.tablet, this.desktop}) : super(key: key);

  double deviceWidth = 0;
  bool isMobile = true;
  bool isTablet = false;
  bool isDesktop = false;

  @override
  Widget build(BuildContext context) {
    getDeviceType(MediaQuery.of(context));
    if(isMobile) {
      return mobile;
    } else if(isTablet) {
      return tablet ?? mobile;
    } else {
      return desktop ?? tablet ?? mobile;
    }
  }

  getDeviceType(MediaQueryData mediaQuery) {
    deviceWidth = mediaQuery.size.width;

    // var orientation = mediaQuery.orientation;

    // Fixed Device width (changes with orientation)
    // if (orientation == Orientation.landscape) {
    //   deviceWidth = mediaQuery.size.height;
    // } else {
    //   deviceWidth = mediaQuery.size.width;
    // }

    if (deviceWidth > 850) {
      isDesktop = true;
      isTablet = false;
      isMobile = false;
    } else if (deviceWidth > 650 && deviceWidth < 850) {
      isTablet = true;
      isDesktop = false;
      isMobile = false;
    } else {
      isMobile = true;
      isTablet = false;
      isDesktop = false;
    }
  }
}
