import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authk_event.dart';
part 'authk_state.dart';

class AuthkBloc extends Bloc<AuthkEvent, AuthkState> {
  AuthkBloc() : super(AuthkInitial()) {
    on<OtpVerificationRequested>(otpRequested);
  }

  void otpRequested(OtpVerificationRequested event, Emitter<AuthkState> emit) {
    emit(AuthkLoading());
    try {
      final phoneNumber = event.phoneNumber;
      getOtpRequested(phoneNumber: phoneNumber);
    } catch (e) {
      return emit(AuthkFailure(error: e.toString()));
    }
  }

  getOtpRequested({required String phoneNumber}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+917510720297',
      verificationCompleted: (phoneAuthCredential) async {
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (error) {
        print("=================");
        print(error.message);
        return emit(AuthkFailure(error: error.code));
      },
      codeSent: (verificationId, forceResendingToken) {
        return emit(AuthKSuccess());
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }
}
