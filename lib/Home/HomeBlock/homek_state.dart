part of 'homek_bloc.dart';

@immutable
sealed class HomekState {}

final class HomekInitial extends HomekState {}
final class HomekLoader extends HomekState {}
final class HomekFailure extends HomekState {}
final class HomekSucces extends HomekState {

}
