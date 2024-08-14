import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_totalx/Auth/controller/auth_controller.dart';
import 'package:flutter_task_totalx/Auth/repository/auth_repository.dart';
import 'package:flutter_task_totalx/addUser/controller/addUser_controller.dart';
import 'package:flutter_task_totalx/addUser/repository/home_repository.dart';
import 'package:flutter_task_totalx/addUser/screen/getbloc/get_bloc.dart';
import 'package:flutter_task_totalx/addUser/screen/pickingImageUrl/picking_image_url_cubit.dart';
import 'package:flutter_task_totalx/addUser/screen/sortBloc/sort_bloc.dart';
import 'Auth/controller/bloc/authk_bloc.dart';
import 'Auth/screen/verificationIdBloc/verification_id_cubit.dart';
import 'Core/Common/blocCommon/storageBlock/storage_bloc.dart';
import 'Core/Common/splashScreen/splashScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'addUser/screen/bloc/add_user_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthkBloc(
                controller: AuthController(
                    repository:
                        AuthRepository(firebaseAuth: FirebaseAuth.instance)))),
        BlocProvider(
            create: (context) => AddUserBloc(
                controller: AddUserController(
                    repository: AddUserRepository(
                        firestore: FirebaseFirestore.instance)))),
        BlocProvider(
            create: (context) => GetBloc(
                controller: AddUserController(
                    repository: AddUserRepository(
                        firestore: FirebaseFirestore.instance)))),
        // BlocProvider(create: (context)=>HomekBloc(firebaseFirestore: FirebaseFirestore.instance)),
        BlocProvider(
            create: (context) =>
                StorageBloc(firebaseStorage: FirebaseStorage.instance)),
        BlocProvider(
            create: (context) =>
                SortBloc()),
        BlocProvider(
            create: (context) =>
                PickingImageUrlCubit()),
        BlocProvider(
            create: (context) =>
                VerificationIdCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
