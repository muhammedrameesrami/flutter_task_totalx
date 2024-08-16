import 'package:bloc/bloc.dart';
import 'package:flutter_task_totalx/addUser/controller/addUser_controller.dart';
import 'package:flutter_task_totalx/userModel.dart';
import 'package:meta/meta.dart';

import '../../../Core/Common/functionCommon/setseach.dart';

part 'add_user_event.dart';
part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  final AddUserController _userController;
  AddUserBloc({required AddUserController controller})
      : _userController = controller,
        super(AddUserInitial()) {
    on<AddUser>(addUser);

  }
  addUser(AddUser event, Emitter<AddUserState> state) async {
    emit(AddUserLoading());
    final res =await _userController.addUser(
        userModel: UserModel(
            name: event.name,
            image: event.image,
            age: event.age,
            search: setSearchParam(event.name) +
                setSearchParam(event.age.toString()), uid: ''));
    res.fold((l) {
     return emit(AddUserFailure(error: l.message));
    }, (r) {


      return emit(AddUserSuccess());
    });
  }


}
