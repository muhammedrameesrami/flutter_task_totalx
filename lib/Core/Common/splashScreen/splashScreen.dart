import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Auth/screen/loginScreen.dart';
import '../assetsConstant/asstesConstants.dart';
import '../globalVariable/GlobalVariable.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => const LoginScreen(),));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: Colors.black,
      body:Center(child:Text('Loading ...........',style: TextStyle(color: Colors.white),)),
    );
  }
}
