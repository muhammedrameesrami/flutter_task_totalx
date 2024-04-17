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
final class SearchUser extends HomekEvent{
  final String search;
  SearchUser({required this.search});
}

final class SortUser extends HomekEvent{
  final String sort;
  SortUser([this.sort="all"]);
}
