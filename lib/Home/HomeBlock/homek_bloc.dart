import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_task_totalx/Core/Common/firebaseConstant/firebaseConstants.dart';
import 'package:flutter_task_totalx/userModel.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';

import '../../Core/Common/failure/failure.dart';

part 'homek_event.dart';
part 'homek_state.dart';

class HomekBloc extends Bloc<HomekEvent, List<UserModel>> {
  final FirebaseFirestore _firebaseFirestore;
  HomekBloc({required FirebaseFirestore firebaseFirestore}) : _firebaseFirestore=firebaseFirestore,super([]) {

    on<FetchUserData>((event, emit) async {
      final fetchUsers=await fetchAllUser();
emit(fetchUsers);
    });

    on<AddUserModel>((event, emit) async {
      emit(state+[event.userModel]);
    });
  }

  Future<List<UserModel>> fetchAllUser() async {
    List <UserModel> usermodel=[];
   final result=await _firebaseFirestore.collection(FirebaseConstants.userCollection).get();
   for(DocumentSnapshot i in result.docs){
     usermodel=usermodel+[UserModel.fromMap(i.data()as Map<String, dynamic>)];
   }
   return usermodel;
  }




}
