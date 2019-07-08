import 'package:flutter/material.dart';
import 'package:flutter_yjapp/widgets/base_dialog.dart';
import 'package:flutter_yjapp/config/header_config.dart';
import 'package:flutter_yjapp/utils/utils_header.dart';

class PayTypeDialog extends StatefulWidget {

  PayTypeDialog({
    Key key,
    this.items
  }):super(key:key);

  final List items;

  @override
  _PayTypeDialogState createState() => _PayTypeDialogState();
}

class _PayTypeDialogState extends State<PayTypeDialog> {

  List _list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list = widget.items;
  }

  void pressItem(int index){
      if(index==0){
        Toast.show('线上支付为必选项');
        return;
      }

      var dic = _list[index];
      dic['flag'] = !dic['flag'];

      setState(() {

      });
  }

  void pressDown(){
    print(_list);
    Navigator.pop(context,_list);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    List<Widget> _widgets = [];
    for(int i=0;i<_list.length;i++){
      var dic = _list[i];
      Widget _widget = InkWell(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(dic['name'],style: TextStyle(color: YJColors.text_dark,fontSize: 13.0),),
                Image.asset(dic['flag']==true ? 'assets/images/shop/xz.png':'assets/images/shop/xztm.png',width: 16.0,),
              ],
            )
        ),
          onTap: ()=> pressItem(i),
        );
      _widgets.add(_widget);
    }

    return MyBaseDialog(
        title: '支付方式（多选）',
        onPress: pressDown,
        hiddenTitle: false,

        child: Column(
          children: _widgets,
        ),
    );
  }
}