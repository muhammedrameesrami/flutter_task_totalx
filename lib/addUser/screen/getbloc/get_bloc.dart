import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_task_totalx/userModel.dart';
import 'package:meta/meta.dart';

import '../../controller/addUser_controller.dart';

part 'get_event.dart';

class GetBloc extends Bloc<GetEvent,List<UserModel>> {

  final AddUserController _controller;
  GetBloc({required AddUserController controller}) :_controller=controller, super([]) {
    on<FetchEvent>((event, emit) async {

     final allUserDoc=await controller.getUser();

     emit(allUserDoc);

    });

    on<AddUserModelGetEvent>((event, emit) async {
     return emit(state+[event.userModel]);
    });


  }
}
