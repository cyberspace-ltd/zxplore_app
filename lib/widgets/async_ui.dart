// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zxplore_app/utils/app_exception.dart';
import 'package:zxplore_app/widgets/alert_dialogs.dart';


extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context,{dynamic okAction,dynamic cancelAction,dynamic errorMsg}) {
    print('Print rec_mssg${errorMsg}');
    if (!isLoading && hasError) {
      showExceptionAlertDialog(
        context: context,
        title: 'Error',
        exception:errorMsg.runtimeType.toString()=='_Exception'? errorMsg.message:  errorMsg??  "Failed to complete request try again.",
        okAction: okAction??(){},cancelAction: cancelAction??(){}
      );
    }
  }

    void showAlertDialogOnSuccess(BuildContext context,
      {dynamic okAction, dynamic cancelAction,required String content, String? cancelActionText,}) {
    if (!isRefreshing && hasError) {
      showAlertDialog(
        context: context,
        title: 'Success',
        content: content,
        cancelActionText: cancelActionText,
        okAction: okAction
      );
    }
  }


  String? checkMessageIsString(dynamic errorMsg){
    debugPrint('Error>>> ${errorMsg.message}');
    if(errorMsg.runtimeType==String ){
      return errorMsg;
    }else if(errorMsg.runtimeType==Exception){
      return errorMsg??'We are unable to process request, try again';
    }
    else if(errorMsg.runtimeType==AppException){
      return errorMsg.message??'We are unable to process request, try again';
    }
    else{
      return 'Something went wrong processing  request';
    }
  }
}
