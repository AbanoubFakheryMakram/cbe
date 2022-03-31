
import 'package:cbe/widgets/responsive_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../test_page.dart';
import '/core/base/service_locator.dart';
import '/core/controllers/navigation/navigation_controller.dart';
import '/core/controllers/network/network_info.dart';
import '/features/users/presentation/manager/users_manager.dart';
import '/widgets/app_loading_overlay.dart';

class UsersPage extends ConsumerWidget {
  UsersPage({Key? key}) : super(key: key);

  final networkInfo = serviceLocator<NetworkInfoController>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _usersManager = ref.watch(usersManager);
    return ResponsivePage(
      mobile: LoadingOverlay(
        isLoading: _usersManager.isLoading,
        progressIndicator: const CircularProgressIndicator(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Users Page'),
          ),
          body: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  serviceLocator<NavigationController>().push(const TestPage());
                },
                title: Text(_usersManager.users[index].name ?? ''),
                subtitle: Text(_usersManager.users[index].email ?? ''),
              );
            },
            itemCount: _usersManager.users.length,
          ),
        ),
      ),
    );
  }
}