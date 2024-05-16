import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class VerificationIdCubit extends Cubit<String> {
  VerificationIdCubit() : super('');
  updateVerificationId({required String id}){
    emit(id);
  }
}
