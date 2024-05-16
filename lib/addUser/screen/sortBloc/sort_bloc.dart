import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../userModel.dart';

part 'sort_event.dart';

class SortBloc extends Bloc<SortEvent, List<UserModel>> {
  SortBloc() : super([]) {
    on<GetElderSortEvent>((event, emit) {
      List<UserModel> userList=event.users;
      List<UserModel> users=[];
      for(int i=0;i<userList.length;i++){
        if(userList[i].age>18){
          users.add(userList[i]);
        }
      }
    });

    on<GetYoungerSortEvent>((event, emit) {
      List<UserModel> userList=event.users;
      List<UserModel> users=[];
      for(int i=0;i<userList.length;i++){
        if(userList[i].age<=18){
          users.add(userList[i]);
        }
      }
    });
  }
}
