import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

showSnackBar({required String message,required BuildContext context}){
  final showSnackBar=SnackBar(content: Text(message));
  return ScaffoldMessenger.of(context).showSnackBar(showSnackBar);
}
