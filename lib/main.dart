import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_totalx/Home/storageBlock/storage_bloc.dart';
import 'Auth/authBlock/authk_bloc.dart';
import 'Core/Common/splashScreen/splashScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Home/HomeBlock/homek_bloc.dart';
import 'Home/addhomeBlock/home_bloc.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider(create: (context)=>AuthkBloc(firebaseAuth: FirebaseAuth.instance)),
      BlocProvider(create: (context)=>HomeBloc( firebaseFirestore: FirebaseFirestore.instance)),
      BlocProvider(create: (context)=>HomekBloc(firebaseFirestore: FirebaseFirestore.instance)),
      BlocProvider(create: (context)=>StorageBloc(firebaseStorage: FirebaseStorage.instance)),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false,
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
