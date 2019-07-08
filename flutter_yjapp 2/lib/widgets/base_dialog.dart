import 'package:flutter/material.dart';
import 'package:flutter_yjapp/config/header_config.dart';

class MyBaseDialog extends StatelessWidget {
  MyBaseDialog({
    Key key,
    @required this.title,
    @required this.onPress,
    @required this.child,
//    this.height = 120.0,
    @required this.hiddenTitle
  }):super(key : key);

  final String title;
  final Function onPress;
  Widget child;
  double height;
  final bool hiddenTitle;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,//创建透明图层
      body: AnimatedContainer( //键盘弹出动画
        duration: Duration(milliseconds: 120),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom ,
        curve: Curves.easeInCubic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 270.0,
//          height: height,
              padding: EdgeInsets.only(top: 24.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(-5, 5),
                      blurRadius: 5.0,
                      spreadRadius: 2.0

                  )
                ],

              ),
              child: Column(
                children: <Widget>[
                  Offstage(
                    offstage: hiddenTitle,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(title,style: TextStyle(fontSize: 18.0,
                          color: YJColors.text_dark,
                          fontWeight: FontWeight.bold),
                      ),

                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: child,
                  ),

                  SizedBox(height: 8.0,),
                  Divider(height: 0.8,color: YJColors.line,),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 48.0,
                          child: FlatButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text('取消',
                                style: TextStyle(fontSize: 18.0,color: YJColors.text_gray),
                              )
                          ),
                        ),
                      ),

                      Container(
                        height: 48.0,
                        width: 0.6,
                        color:YJColors.line,
                      ),

                      Expanded(
                        child: Container(
                          height: 48.0,
                          child: FlatButton(
                            onPressed: (){
                              onPress();
                            },
                            child: Text('确定',style: TextStyle(color: YJColors.app_main,fontSize: 18.0),),
                          ),
                        ),
                      )

                    ],
                  )



                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

