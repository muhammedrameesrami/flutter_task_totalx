import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../Core/Common/assetsConstant/asstesConstants.dart';
import '../../Core/Common/globalVariable/GlobalVariable.dart';
import 'otpScreen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              SizedBox(
                height: height * 0.18,
                width: width,
                child: Image.asset(AssetsConstant.loginImage),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Text(
                'Enter Phone Number',
                style: TextStyle(
                    fontSize: width * 0.045, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              SizedBox(
                height: height * 0.06,
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Enter Phone Number *',
                      labelStyle: TextStyle(
                          fontSize: width * 0.035, color: Colors.grey),
                      // hintText: 'Enter Phone Number *',
                      // hintStyle: TextStyle(fontSize: width*0.035,color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey.shade100))),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "By Continuing, I agree to TotalX's",
                      style: TextStyle(
                          fontSize: width * 0.035,
                          color: Colors.grey.shade600)),
                  TextSpan(
                      text: ' Terms and conditions',
                      style: TextStyle(
                          fontSize: width * 0.035, color: Colors.lightBlue),
                      recognizer: TapGestureRecognizer()..onTap = () {}),
                  TextSpan(
                      text: '& ',
                      style: TextStyle(
                          fontSize: width * 0.035,
                          color: Colors.grey.shade600)),
                  TextSpan(
                      text: 'privacy policy',
                      style: TextStyle(
                          fontSize: width * 0.035, color: Colors.lightBlue),
                      recognizer: TapGestureRecognizer()..onTap = () {}),
                ]),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => OtpScreen(
                          phoneNumber: phoneController.text.trim(),
                        ),
                      ));
                },
                child: Container(
                  height: height * 0.06,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height * 0.25),
                      color: Colors.black),
                  child: Center(
                      child: Text(
                        'Get OTP',
                        style:
                        TextStyle(fontSize: width * 0.05, color: Colors.white),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
