part of 'homek_bloc.dart';

@immutable
sealed class HomekEvent {

}

final class FetchUserData extends HomekEvent{

}
final class AddUserModel extends HomekEvent {
  final UserModel userModel;
  AddUserModel({required this.userModel});
}
