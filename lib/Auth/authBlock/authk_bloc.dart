import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

part 'authk_event.dart';
part 'authk_state.dart';

class AuthkBloc extends Bloc<AuthkEvent, AuthkState> {
final FirebaseAuth _firebaseAuth;
  AuthkBloc({required FirebaseAuth firebaseAuth}) : _firebaseAuth=firebaseAuth,super(AuthkInitial()) {
    on<OtpVerificationRequested>(otpRequested);
    on<OtpVerification>(ortpVerification);
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

  Future<void> ortpVerification(OtpVerification event, Emitter<AuthkState> emit) async {

      try {
        emit(AuthkLoading());
        PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: event.verificationId, smsCode: event.otp);
        final res=await _firebaseAuth.signInWithCredential(credential);
        if(res.user==null){
          return emit(AuthkFailure(error: 'Invalid OTP'));
        }
        return emit(AuthKSuccess(verificationId: ""));
      } on FirebaseAuthException catch (error) {
        return emit(AuthkFailure(error: error.toString()));
        throw error.message!;
      } catch (e) {
        return emit(AuthkFailure(error: e.toString()));
      }
    }


  getOtpRequested({required String phoneNumber}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (phoneAuthCredential) async {
        await _firebaseAuth.signInWithCredential(phoneAuthCredential);

      },
      verificationFailed: (error) {

        return emit(AuthkFailure(error: error.code));
      },
      codeSent: (verificationId, forceResendingToken) {

        return emit(AuthKSuccess(verificationId: verificationId??""));

      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

}
