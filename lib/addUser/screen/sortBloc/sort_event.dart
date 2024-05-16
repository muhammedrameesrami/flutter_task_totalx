part of 'sort_bloc.dart';

@immutable
sealed class SortEvent {}

final class GetElderSortEvent extends SortEvent{
  final List<UserModel> users;
  GetElderSortEvent({required this.users});
}

final class GetYoungerSortEvent extends SortEvent{
  final List<UserModel> users;
  GetYoungerSortEvent({required this.users});
}