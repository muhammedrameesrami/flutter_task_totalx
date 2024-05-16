part of 'add_user_bloc.dart';

@immutable
sealed class AddUserEvent {}

final class AddUser extends AddUserEvent{
  final String name;
  final int age;
  final String image;

  AddUser({required this.image,required this.name,required this.age});

}