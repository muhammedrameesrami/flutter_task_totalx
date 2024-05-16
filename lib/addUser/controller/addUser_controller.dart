import 'package:fpdart/fpdart.dart';

import '../../Core/Common/failure/failure.dart';
import '../../userModel.dart';
import '../repository/home_repository.dart';

class AddUserController {
  final AddUserRepository _repository;
  AddUserController({required AddUserRepository repository}):_repository=repository;

  /// add user controller function then go to homebloc
  Future<Either<Failure, String>> addUser(
      {required UserModel userModel}) async {
    return _repository.addUser(userModel: userModel);
  }

  ///fetch user data controller and goto homebloc
  Stream<List<UserModel>> fetchUser(){
    return _repository.fetchUser();
  }

  Future<List<UserModel>> getUser() async {
    return _repository.getUser();
  }
  }