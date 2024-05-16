import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_task_totalx/Core/Common/failure/failure.dart';
import 'package:flutter_task_totalx/Core/Common/firebaseConstant/firebaseConstants.dart';
import 'package:flutter_task_totalx/userModel.dart';
import 'package:fpdart/fpdart.dart';

import '../../Core/Common/functionCommon/setseach.dart';

class AddUserRepository {
  final FirebaseFirestore _firestore;
  AddUserRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _user =>
      _firestore.collection(FirebaseConstants.userCollection);


  /// add user repository then go to home controller
  Future<Either<Failure, String>> addUser(
      {required UserModel userModel}) async {
    try {
      await _user.add(userModel.toMap()).then((value) {
        final user = userModel.copyWith(
           uid: value.id);
        value.update(user.toMap());
      });
      return right('successfully added');
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  ///fetch all user data and go to home controller
  Stream<List<UserModel>> fetchUser(){
    return _user.snapshots().map((event) {
      return event.docs.map((e) {
       return  UserModel.fromMap(e.data() as Map<String ,dynamic>);
      }).toList();

    });
  }

  Future<List<UserModel>> getUser() async {
    final allUserDocs =await _user.get();
    List<UserModel> users=[];
    for(QueryDocumentSnapshot i in allUserDocs.docs){
      users.add(UserModel.fromMap(i.data() as Map<String ,dynamic>));
    }
  return users;
  }

}
