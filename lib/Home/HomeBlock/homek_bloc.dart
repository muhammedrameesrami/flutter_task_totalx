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

    on<SortUser>((event, emit) async {
      List<UserModel> users=[];
var user=[...state];
if(event.sort=='Elder') {
  for (int i = 0; i < user.length ; i++) {
    if (user[i].age > 60) {
      users.add(user[i]);
    }
  }
}if(event.sort=='Younger'){
  for(int j=0;j<user.length;j++){
    if(user[j].age<60){
      users.add(user[j]);
  }
  }
      }
emit(users);
    });

    on<SearchUser>((event, emit) async {
var users=[...state];

List<UserModel> user= [];
if(event.search.isNotEmpty)
for(int i =0;i<users.length;i++){
  if(users[i].search.contains(event.search.toUpperCase())){
    print("ys");
    user.add(users[i]);
  }
}
emit(user);
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
