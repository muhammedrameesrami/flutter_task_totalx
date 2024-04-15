part of 'authk_bloc.dart';

@immutable
sealed class AuthkEvent {}

final class OtpVerificationRequested extends AuthkEvent {
  final String phoneNumber;
  OtpVerificationRequested({required this.phoneNumber});
}
