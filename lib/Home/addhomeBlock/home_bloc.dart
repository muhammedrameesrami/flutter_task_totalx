import 'package:bloc/bloc.dart';
import 'package:flutter_task_totalx/Core/Common/firebaseConstant/firebaseConstants.dart';
import 'package:flutter_task_totalx/userModel.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseFirestore _firebaseFirestore;

  HomeBloc({required FirebaseFirestore firebaseFirestore}) :
       _firebaseFirestore=firebaseFirestore ,
        super(HomeInitial()) {
    on<AddUser>(addUser);
  }

   addUser(AddUser event,Emitter<HomeState>emit) async {
    emit(HomeLoader());
    try{
      final result=await _firebaseFirestore.collection(FirebaseConstants.userCollection)
          .add(event.userModel.toMap()).then((value) {
          final user= event.userModel.copyWith(search: setSearchParam(event.userModel.name,));
value.update(user.toMap());
return emit(HomeSuccess());
      });
    }catch (e){
      return emit(HomeFailure(error: e.toString()));
    }
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = <String>[];
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = "$name${nameSplits[k]} ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }
}
