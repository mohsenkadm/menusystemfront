

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:menusystemfront/res/colors/app_color.dart';
class Utils {


    static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode  nextFocus ){
      current.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }


    static toastMessage(String message){
      Fluttertoast.showToast(
          msg: message ,
        backgroundColor: AppColor.blackColor ,
        textColor: AppColor.whiteColor,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,


      );
    }


    static toastMessageCenter(String message){
      Fluttertoast.showToast(
        msg: message ,
        backgroundColor: AppColor.blackColor ,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG,
        textColor: AppColor.whiteColor,
      );
    }

    static snackBar(String title, String message){
      Get.rawSnackbar(
        titleText: Text(title,style: Theme.of(Get.context!).textTheme.bodySmall),
         messageText:  Text(message,
         style:  Theme.of(Get.context!).textTheme.bodySmall
         ),
         isDismissible: true,
         snackPosition: SnackPosition.BOTTOM,
         duration: const Duration(seconds: 2),
         backgroundColor: Colors.green,
         margin: EdgeInsets.zero,
         snackStyle: SnackStyle.FLOATING,
         icon:const Icon(Icons.error,color: AppColor.whiteColor, size: 25,)
         );
    }
}