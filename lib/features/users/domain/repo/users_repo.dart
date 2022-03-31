
import '/features/users/data/models/responses/users_response_model.dart';

abstract class UsersRepo {
  Future<List<UsersResponseModel>> getUsers();
}