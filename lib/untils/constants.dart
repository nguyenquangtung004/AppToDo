//lottie assets address
//Khai báo địa chỉ file lottie
import 'package:app_to_do/main.dart';
import 'package:app_to_do/untils/app_str.dart';
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

String lottieUrl = 'assets/lottie/1.json';

/// Empty title QR SubTitle TextField warning
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStr.oopsMsg,
      subMsg: 'You Must Fill All Fields',
      duration: 2000,
      padding: const EdgeInsets.all(20),
      corner: 20.0);
}

/// NoThing Entered When User Try To Edit Or Update The Current Task
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStr.oopsMsg,
      subMsg: 'You Must Edit The Tasks The Try To Update It !',
      duration: 5000,
      padding: const EdgeInsets.all(20),
      corner: 20.0);
}

///No task warning dialog for delete
dynamic noTaskWarning(BuildContext context) {
  PanaraConfirmDialog.showAnimatedGrow(
    context,
    title: AppStr.oopsMsg,
    message:
        "There is no Task for delete!\nTry adding some and then try to delete it!",
    confirmButtonText: "Okay",
    // Thay vì buttonText
    onTapCancel: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    cancelButtonText: "Cancel ",
    onTapConfirm: () {
      Navigator.of(context).pop();
    },
  );
}

///Delete all task from db dialog
dynamic deleteAllTask(BuildContext context) {
  return PanaraConfirmDialog.show(
      context,
      title: AppStr.areYouSure,
      message: "Do You really want to delete all tasks? You will no be able to undo this action!",
      confirmButtonText: "Yes",
      cancelButtonText: "No",
      onTapConfirm: (){
        //We will clear all box data using this command later on
        // BaseWidget.of(context).dataStore.box.clear();
        Navigator.pop(context);
      },
      onTapCancel: (){
        Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.error,
      barrierDismissible: false
  );
}
