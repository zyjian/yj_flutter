import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {

  const MyAppBar({
    Key key,
    this.backgroudColor:Colors.white,
    this.title:'',
    this.centerTitle:'',
    this.actionName:'',
    this.backImg:'assets/images/ic_back_black.png',
    this.onPress,
    this.isBack:true
  }):super(key:key);

  final Color backgroudColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPress;
  final bool isBack;


  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(48.0);

  @override
  _MyAppBarState createState() => new _MyAppBarState();

}
class _MyAppBarState extends State <MyAppBar> {
  SystemUiOverlayStyle _overlayStyle = SystemUiOverlayStyle.light;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _overlayStyle = ThemeData.estimateBrightnessForColor(widget.backgroudColor)==Brightness.dark?SystemUiOverlayStyle.light:SystemUiOverlayStyle.dark;
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
