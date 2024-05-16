import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class PickingImageUrlCubit extends Cubit<String> {
  PickingImageUrlCubit() : super('');
  updateImageUrl({required String url}){
    emit(url);
  }
}
