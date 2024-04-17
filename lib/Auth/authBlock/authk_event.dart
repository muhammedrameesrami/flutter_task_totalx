part of 'authk_bloc.dart';

@immutable
sealed class AuthkEvent {}

final class OtpVerificationRequested extends AuthkEvent {
  final String phoneNumber;
  OtpVerificationRequested({required this.phoneNumber});
}
final class OtpVerification extends AuthkEvent {
  final String otp;
  final String verificationId;
  OtpVerification({required this.otp,required this.verificationId});
}