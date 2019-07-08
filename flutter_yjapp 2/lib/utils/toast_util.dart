import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class Toast {

  static show(String msg,{duration = 2000}){

    showToast(
        msg,
        duration: Duration(milliseconds:duration ),
        position: ToastPosition.bottom,
        backgroundColor: Colors.black54.withOpacity(0.3),
        radius: 20.0,
        textStyle: TextStyle(fontSize: 14.0),
        textPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
    );
  }

  static cancelToast(){
    dismissAllToast();
  }
}
