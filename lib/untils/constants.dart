//lottie assets address
//Khai báo địa chỉ file lottie
import 'package:app_to_do/untils/app_str.dart';
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
String lottieUrl = 'assets/lottie/1.json';

/// Empty title QR SubTitle TextField warning
emptyWarning (BuildContext context){
  return FToast.toast(context,msg: AppStr.oopsMsg,subMsg: 'You Must Fill All Fields');
}
