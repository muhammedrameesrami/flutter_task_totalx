part of 'get_bloc.dart';

@immutable
sealed class GetEvent {}

final class FetchEvent extends GetEvent{}

final class AddUserModelGetEvent extends GetEvent{
  final UserModel userModel;
  AddUserModelGetEvent({required this. userModel});
}