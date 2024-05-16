part of 'authk_bloc.dart';

@immutable
sealed class AuthkEvent {}

final class OtpVerificationRequested extends AuthkEvent {
  final String phoneNumber;
  final BuildContext context;
  OtpVerificationRequested({required this.phoneNumber,required this.context});
}
final class OtpVerification extends AuthkEvent {
  final String otp;
  final String verificationId;
  OtpVerification({required this.otp,required this.verificationId});
}