
import 'package:responsive_framework/responsive_wrapper.dart';

class AppSizes {
  static List<ResponsiveBreakpoint>? breakpoints = [
    const ResponsiveBreakpoint.resize(450, name: 'MOBILE'),
    const ResponsiveBreakpoint.autoScale(650, name: 'TABLET'),
    const ResponsiveBreakpoint.resize(850, name: 'DESKTOP'),
    const ResponsiveBreakpoint.autoScale(1550, name: 'WEB'),
  ];
}
