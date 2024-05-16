part of 'add_user_bloc.dart';

@immutable
sealed class AddUserState {}

final class AddUserInitial extends AddUserState {}

/// add user all state class
final class AddUserSuccess extends AddUserState {
  final String message;
  AddUserSuccess({ this. message=''});
}

final class AddUserFailure extends AddUserState {
  final String error;
  AddUserFailure({required this.error});
}

final class AddUserLoading extends AddUserState {}


