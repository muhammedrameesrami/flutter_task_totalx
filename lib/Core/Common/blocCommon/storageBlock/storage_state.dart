part of 'storage_bloc.dart';

@immutable
sealed class StorageState {}

final class StorageInitial extends StorageState {}
final class StorageFailure extends StorageState {
  final String error;
  StorageFailure({required this.error});
}
final class StorageSuccess extends StorageState {
  final String url;
  StorageSuccess({required this.url});
}
final class StorageLoader extends StorageState {}
