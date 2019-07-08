import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yjapp/config/colors_config.dart';
import 'package:flutter_yjapp/utils/utils_header.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {

  SearchBar({
   Key key,
   @required this.backgroundColor,
   this.backImg:'assets/images/ic_back_black.png',
   @required this.onPress,
   @required this.hintText
  }):super(key:key);

  final Color backgroundColor;
  final String backImg;
  final String hintText;
  final Function(String) onPress;

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(48.0);
}

class _SearchBarState extends State<SearchBar> {

  SystemUiOverlayStyle _overlayStyle = SystemUiOverlayStyle.dark;
  TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }


  Color getColor(){
    return _overlayStyle==SystemUiOverlayStyle.light?Colors.white:YJColors.text_dark;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnnotatedRegion(
      value: _overlayStyle,
      child: Material(
        color: widget.backgroundColor,
        child: SafeArea(
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 48.0,
                  height: 48.0,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Image.asset(widget.backImg,color: getColor(),),
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 32.0,
                    decoration: BoxDecoration(
                      color: YJColors.bg_color,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: TextField(
                      controller: _editingController,
                      autofocus: true,
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 6.0),
                        border: InputBorder.none,
                        icon: Padding(
                          padding: EdgeInsets.only(left: 8.0,top: 8.0,bottom: 8.0,right: 0),
                          child: loadAssetImage('order/order_search'),
                        ),
                        hintText: widget.hintText,
                        hintStyle: TextStyle(fontSize: 14.0,color: YJColors.text_gray),
                        suffixIcon: InkWell(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.0,top: 8.0,bottom: 8.0),
                            child: loadAssetImage('order/order_delete'),
                          ),
                          onTap: (){
                            _editingController.text='';
                          },
                        )

                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 8.0,right: 16.0),
                  height: 32.0,
                  width: 44.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: YJColors.app_main,

                  ),
                  child: InkWell(
                    onTap: ()=>widget.onPress(_editingController.text),
                    child: Text('搜索',style: TextStyle(fontSize: 14.0,color: Colors.white),),

                  ),
                )


              ],
            ),
          )
        ),
      ),
    );
  }
}