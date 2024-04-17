part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}
final class AddUser extends HomeEvent{
final UserModel userModel;
AddUser({required this. userModel});
}
