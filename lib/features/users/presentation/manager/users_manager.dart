
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/core/base/service_locator.dart';
import '/features/users/data/models/responses/users_response_model.dart';
import '/features/users/domain/use_cases/users_usercase.dart';
import '../../../../core/base/base_manager.dart';

var usersManager = ChangeNotifierProvider((_) => UsersManager());

class UsersManager extends BaseManager with ChangeNotifier {

  UsersManager() {
    loadUsers();
  }

  List<UsersResponseModel> users = [];
  var usersUsecase = serviceLocator<UsersUsecase>();

  void loadUsers() async {
    isLoading = true;
    users = await usersUsecase.getUsers();
    isLoading = false;
    notifyListeners();
  }
}