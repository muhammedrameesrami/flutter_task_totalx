part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeSuccess extends HomeState {}
final class HomeFailure extends HomeState {
  final String error;
  HomeFailure({required this.error});
}
final class HomeLoader extends HomeState {}
