
import 'package:flutter/material.dart';

class DeviceNotSafePage extends StatelessWidget {
  const DeviceNotSafePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Can Not Run The App On This Device'),
      ),
    );
  }
}
