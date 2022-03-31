import 'package:flutter/material.dart';
import '/l10n/app_localization.dart';
import '/core/controllers/navigation/navigation_controller.dart';
import '/core/controllers/network/network_info.dart';
import '../../../../core/base/service_locator.dart';
import '../../../../utils/constants/app_colors.dart';

class NoInternetConnectionPage extends StatelessWidget {
  final VoidCallback? afterNetworkBackCallback;

  NoInternetConnectionPage({Key? key, this.afterNetworkBackCallback}) : super(key: key);

  final NetworkInfoController connectivityService = serviceLocator<NetworkInfoController>();
  final NavigationController navigationService = serviceLocator<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalization.translation.noInternetConnection),
              ElevatedButton(
                onPressed: () {
                  _checkNetwork();
                },
                child: Text(AppLocalization.translation.retry),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkNetwork() async {
    if (await connectivityService.isConnected) {
      afterNetworkBackCallback?.call();
      navigationService.pop();
    }
  }
}
