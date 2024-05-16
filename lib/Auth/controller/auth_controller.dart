import 'package:flutter/cupertino.dart';
import 'package:flutter_task_totalx/Auth/repository/auth_repository.dart';
import 'package:flutter_task_totalx/Core/Common/failure/failure.dart';
import 'package:fpdart/fpdart.dart';

class AuthController{
  final AuthRepository _repository;
  AuthController({required AuthRepository repository}):
      _repository=repository;

  Future<Either<Failure ,String>>requestOtp({required String number,required BuildContext context}) async {
   return await _repository.requestOtp(number: number,context: context);
  }

  Future<Either<Failure ,String>>verifyOtp({required String otp,required String verificationId}) async {
    return await _repository.verifyOtp(verificationId: verificationId, otp: otp);
  }

}