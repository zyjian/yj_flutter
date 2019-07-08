import 'package:flutter/material.dart';
import 'package:flutter_yjapp/config/header_config.dart';
import 'package:flutter_yjapp/widgets/base_dialog.dart';

class FreightTypeDialog extends StatefulWidget {
  FreightTypeDialog({
    Key key,
    @required this.items,
    @required this.selectIndex = 0
  });
  
  final List<String>items;
  var selectIndex;
  
  @override
  _FreightTypeDialogState createState() => _FreightTypeDialogState();
}

class _FreightTypeDialogState extends State<FreightTypeDialog> {

  void pressItem(int index){
    widget.selectIndex = index;
    setState(() {

    });
  }

  void pressDown(){
    Navigator.pop(context,widget.selectIndex);
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> _widgets = [];
    
    for(int i=0;i<widget.items.length;i++){
      String name = widget.items[i];
      Widget _widget = InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(name,style: TextStyle(fontSize: 13.0,color: widget.selectIndex==i?YJColors.app_main:YJColors.text_dark),),
              Offstage(
                offstage: widget.selectIndex==i?false:true,
                child: Image.asset('assets/images/order/ic_check.png',width: 16.0,),
              ),
            ],
          ),
        ),
        
        onTap: ()=>pressItem(i),
      );

      _widgets.add(_widget);
    }
    
    
    return MyBaseDialog(
        title: '运费配置', 
        onPress: pressDown,
        child: Column(
          children: _widgets,
        ), 
        hiddenTitle: false
    );
  }
}


