import 'package:flutter/material.dart';


typedef void CallBack();
class MyNavbar {

  static TextStyle textStyleRight = TextStyle(fontSize: 13.0);

  static TextTheme textTheme(){
    return TextTheme(
        title: TextStyle(fontSize: 16.0,color: Colors.black)
    );
  }

  static Widget leading(@required BuildContext context,{CallBack onPresss}){
    return IconButton(
      icon: Image.asset('assets/images/ic_back_black.png',
        width: 20.0,
      ),

      onPressed: (){
        if(onPresss is CallBack){
          onPresss();
        }else{
          Navigator.maybePop(context);
        }
      },
    );
  }
}