import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_totalx/Core/Common/failure/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../screen/verificationIdBloc/verification_id_cubit.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  AuthRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  /// request otp in firebase repository
  Future<Either<Failure, String>> requestOtp(
      {required String number, required BuildContext context}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91$number',
        verificationCompleted: (phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw error.code;
        },
        codeSent: (verificationId, forceResendingToken) {
          context
              .read<VerificationIdCubit>()
              .updateVerificationId(id: verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
      return right('');
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  /// verified the resived firebase otp is correct or not
  Future<Either<Failure, String>> verifyOtp(
      {required String verificationId, required String otp}) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      final res = await _firebaseAuth.signInWithCredential(credential);
      if (res.user == null) {
        return left(Failure('InValid Otp'));
      }
      return right('Successfully Verified');
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
