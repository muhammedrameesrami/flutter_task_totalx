import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

import '../../Core/Common/failure/failure.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  StorageBloc() : super(StorageInitial()) {
    on<AddDocStorage>(addImageToStorage);
  }

   addImageToStorage(AddDocStorage event,Emitter <StorageState>state) async {
     emit(StorageLoader());

     try {
      String downloadUrl='';
      File? selectedImageInBytes;
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) {
        return emit(StorageFailure(error: 'file pickin canceled'));
      }

      selectedImageInBytes = File(result.files.first.path!);
      // Check file extension
      if (result.files.first.extension?.toLowerCase() != 'jpg' &&
          result.files.first.extension?.toLowerCase() != 'jpeg' &&
          result.files.first.extension?.toLowerCase() != 'png') {
        return emit(StorageFailure(error: 'Selected file is not an image'));
      }

      var storageRef = FirebaseStorage.instance
          .ref()
          .child("docs/images/${DateTime.now().microsecondsSinceEpoch}");
      final metaData = SettableMetadata(contentType: 'image/jpeg');
      var uploadTask =
      await storageRef.putFile(selectedImageInBytes!, metaData);
      downloadUrl = await uploadTask.ref.getDownloadURL();
      return emit(StorageSuccess(url: downloadUrl));
    } catch (e) {
      return emit(StorageFailure(error: e.toString()));
    }
  }
}
