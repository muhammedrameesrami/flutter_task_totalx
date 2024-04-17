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
          final user= event.userModel.copyWith();
value.update(user.toMap());
return emit(HomeSuccess());
      });
    }catch (e){
      return emit(HomeFailure(error: e.toString()));
    }
  }
}
