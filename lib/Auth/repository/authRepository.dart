import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_task_totalx/Core/Common/firebaseConstant/firebaseConstants.dart';
import 'package:flutter_task_totalx/userModel.dart';

class AuthRepository{
final FirebaseAuth _firebaseAuth;
final FirebaseFirestore _firestore;

AuthRepository({required FirebaseFirestore firebaseFirestore,required FirebaseAuth firebaseAuth })
  :_firebaseAuth=firebaseAuth,
_firestore=firebaseFirestore;

CollectionReference get _user=>_firestore.collection(FirebaseConstants.userCollection);

Future<void> userAuth()async{

}

}