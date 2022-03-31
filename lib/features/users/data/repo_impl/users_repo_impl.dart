
import 'package:dartz/dartz.dart';
import '/core/controllers/exector/executor.dart';
import '../../../../core/base/api_routes.dart';
import '../../../../core/controllers/http/http_controller_impl.dart';
import '/features/users/data/models/responses/users_response_model.dart';
import '/features/users/domain/repo/users_repo.dart';

class UsersRepoImpl extends HttpControllerImpl implements UsersRepo {

  final ActionExecutor actionExecutor;

  UsersRepoImpl(this.actionExecutor);

  @override
  Future<List<UsersResponseModel>> getUsers() async {
    var result = await actionExecutor.execute(() async {
      var response = await get(ApiRoutes.users());
      List<UsersResponseModel> users = [];
      response.data.forEach((e) {
        users.add(UsersResponseModel.fromJson(e));
      });
      return Right(users);
    });

    if (result is Right) return (result as Right).value;
    return [];
  }
}