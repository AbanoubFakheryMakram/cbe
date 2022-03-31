
import 'package:dartz/dartz.dart';
import '../repo/users_repo.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/responses/users_response_model.dart';

class UsersUsecase {
  final UsersRepo usersRepo;

  UsersUsecase(this.usersRepo);

  Future<List<UsersResponseModel>> getUsers() async {
    return await usersRepo.getUsers();
  }
}