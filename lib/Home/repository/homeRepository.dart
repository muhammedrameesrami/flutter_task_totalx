import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_task_totalx/Core/Common/failure/failure.dart';
import 'package:flutter_task_totalx/Core/Common/firebaseConstant/firebaseConstants.dart';
import 'package:flutter_task_totalx/userModel.dart';
import 'package:fpdart/fpdart.dart';

class HomeRepository{
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;
  HomeRepository({required FirebaseFirestore firebaseFirestore,required FirebaseStorage firebaseStorage }):
      _firebaseStorage=firebaseStorage,
  _firebaseFirestore=firebaseFirestore;

  CollectionReference get _user=>FirebaseFirestore.instance.collection(FirebaseConstants.userCollection);

  Either<Failure, dynamic> addUser({required String uId}){
    try{
return right(_user.doc(uId)
);
    }on FirebaseException catch(e){
      throw e.message!;
    }
    catch (error){
      return left(Failure(error.toString()));
    }
  }
}