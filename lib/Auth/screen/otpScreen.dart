import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_totalx/Auth/screen/verificationIdBloc/verification_id_cubit.dart';
import 'package:pinput/pinput.dart';
import '../../Core/Common/SnackBar/ShowSnackBar.dart';
import '../../Core/Common/assetsConstant/asstesConstants.dart';
import '../../Core/Common/globalVariable/GlobalVariable.dart';
import '../../addUser/screen/homeScreen.dart';
import '../controller/bloc/authk_bloc.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const OtpScreen(
      {super.key, required this.verificationId, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
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
                child: Image.asset(AssetsConstant.otpImage),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Text(
                'OTP Verification',
                style: TextStyle(
                    fontSize: width * 0.045, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: height * 0.035,
              ),
              Text(
                'Enter the verification code we just sent to your number +91 ********${widget.phoneNumber}',
                style: TextStyle(
                    fontSize: width * 0.04, color: Colors.grey.shade600),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Pinput(
                controller: otpController,
                keyboardType: TextInputType.number,
                length: 6,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Get OTP?",
                    style: TextStyle(fontSize: width * 0.035),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Resend',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: width * 0.035),
                      ))
                ],
              ),
              BlocConsumer<AuthkBloc, AuthkState>(
                listener: (context, state) {
                  if (state is AuthKSuccess) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }
                  if (state is AuthkFailure) {
                    showSnackBar(message: 'otp verification failed', context: context);
                  }
                },
                builder: (context, state) {
                  if (state is AuthkLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return BlocBuilder<VerificationIdCubit, String>(
  builder: (context, state) {
    return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeScreen()));
                      context.read<AuthkBloc>().add(OtpVerification(
                          otp: otpController.text.trim(),
                          verificationId: state));
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    },
                    child: Container(
                      height: height * 0.06,
                      width: width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(height * 0.25),
                          color: Colors.black),
                      child: Center(
                        child: Text(
                          'Verify',
                          style: TextStyle(
                              fontSize: width * 0.04, color: Colors.white),
                        ),
                      ),
                    ),
                  );
  },
);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
