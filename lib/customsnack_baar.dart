import 'package:flutter/material.dart';
import 'package:get/get.dart';


void CustomSnackBar(  String msg, String type,{int? duration}) {
  Get.rawSnackbar(
    messageText: Text(msg,style: const TextStyle(color: Colors.white,fontSize: 16,),),
    icon: type == "S"
        ? const Icon(
            Icons.check_circle_rounded,
            color: Colors.white,
          
          )
        : type == "E"
            ? const Icon(
                Icons.error_outline_rounded,
                color: Colors.white
              )
            : const Icon(
                Icons.warning_amber_rounded,
                color: Colors.white
              ),
     backgroundColor: type=="S"?Colors.brown:type=="E"?Colors.redAccent:Colors.orangeAccent,
    duration:  Duration(seconds:duration??2 ),
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    snackPosition: SnackPosition.TOP,
    borderRadius: 5,
    animationDuration: const Duration(milliseconds: 1000),
    // backgroundGradient: const LinearGradient(
    //   colors: [ColorConstant.primaryBlue, ColorConstant.primaryBlue],
    // ),
  );
}
