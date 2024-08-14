import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../controller/auth_controller.dart';

part 'authk_event.dart';
part 'authk_state.dart';

class AuthkBloc extends Bloc<AuthkEvent, AuthkState> {
  final AuthController _authController;
  AuthkBloc({required AuthController controller})
      : _authController = controller,
        super(AuthkInitial()) {
    on<OtpVerificationRequested>(otpRequest);
    on<OtpVerification>(otpVerify);
  }

  /// otp requst bloc class here show it succes or fail
  Future<void> otpRequest(
      OtpVerificationRequested event, Emitter<AuthkState> emit) async {
    emit(AuthkLoading());
    try {
      final res = await _authController.requestOtp(
          number: event.phoneNumber, context: event.context);
      res.fold((l) => emit(AuthkFailure(error: l.message)), (verificationId) {//fold the controller left show failure and right show success
        return emit(AuthKSuccess(verificationId: verificationId));//emit the right
      });
    } catch (e) {// catch any exeption
      return emit(AuthkFailure(error: e.toString()));
    }
  }

  Future<void> otpVerify(
      OtpVerification event, Emitter<AuthkState> emit) async {
    emit(AuthkLoading());
    try {
      final res = await _authController.verifyOtp(
          otp: event.otp, verificationId: event.verificationId);
      res.fold(
          (l) => emit(AuthkFailure(error: l.message)), (r) => AuthKSuccess());
    } catch (e) {
      return emit(AuthkFailure(error: e.toString()));
    }
  }
}
