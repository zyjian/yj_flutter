import 'package:flutter/material.dart';
import 'package:flutter_yjapp/config/header_config.dart';
import 'package:flutter_yjapp/main/settting/setting_page.dart';
import 'package:flutter_yjapp/main/notice/notice_page.dart';
import 'package:flutter_yjapp/widgets/base_dialog.dart';
import 'shop_setting_page.dart';
import 'acount_recoder_page.dart';

class ShopPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    void goSettingPage(){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
          return SettingPage();
      }));
    }

    void goNoticePage(){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
        return NoticePage();
      }));
    }

    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(

        actions: <Widget>[
          IconButton(icon: Image.asset('assets/images/shop/message.png',
            width: 24.0,
            height: 24.0,
          ), onPressed: goNoticePage,),

          IconButton(icon: Image.asset('assets/images/shop/setting.png',
            width: 24.0,
            height: 24.0,
          ), onPressed: goSettingPage),
        ],
      ),

      body: ListView(
        children: <Widget>[
          ShopBody()
        ],
      ),
    );
  }
}
class ShopBody extends StatelessWidget {

  final items1 = [
    {"icon": 'assets/images/shop/zhls.png',
      "name":'账户流水'
    },
    {"icon": 'assets/images/shop/zjgl.png',
      "name":'资金管理'
    },
    {"icon": 'assets/images/shop/txzh.png',
      "name":'提现账号'
    }
  ];

  final items2 = [
    {"icon": 'assets/images/shop/dpsz.png',
      "name":'店铺设置'
    }
  ];





  @override
  Widget build(BuildContext context) {

    void row1Back(index){
      print('账户 $index');
      if(index==0){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
          return AcountRecoderPage();
        }));
      }else{
        showDialog(
            context: context,
            barrierDismissible: false,
            builder:(BuildContext context){
              return MyBaseDialog(
                title: '温馨提示',
                hiddenTitle: false,
                onPress: (){

                },
                child: Text('this is content this is contentthis is contentthis is content'),
              );
            }
        );
      }

    }

    void row2Back(index){
      print('店铺 $index');
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
        return ShopSettingPage();
      }));
    }


    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          ShopHeader(),

          SizedBox(height: 10.0,),
          Container(
            height: 0.6,
            decoration: BoxDecoration(
              color: YJColors.line
            ),
          ),

          SectionCell(title: '账户',items: items1,sendBlock: row1Back,),

          SizedBox(height: 20.0,),

          Container(
            height: 0.6,
            decoration: BoxDecoration(
                color: YJColors.line
            ),
          ),
          SectionCell(title: '店铺',items: items2,sendBlock: row2Back,),
        ],
      ),
    );
  }
}


class ShopHeader extends StatefulWidget {
  
  @override
  _ShopHeaderState createState() => _ShopHeaderState();
}

class _ShopHeaderState extends State<ShopHeader> {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('官方直营店',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            SizedBox(height: 5.0,),
            Row(
              children: <Widget>[
                Image.asset('assets/images/shop/zybq.png',
                  width: 40.0,
                ),
                Text('  店铺账号：15000000000',style: TextStyle(fontSize: 12.0),)
              ],
            )
          ],
        ),
        IconButton(
          iconSize: 56.0,
          icon: Image.asset('assets/images/shop/tx.png',
            fit:BoxFit.fill,
          ),
          onPressed: null
        )
      ],
    );
  }
}



typedef  void callBack(int index);

class SectionCell extends StatefulWidget {

  SectionCell({
    Key key,
    @required this.items,
    @required this.sendBlock,
    @required this.title

  }):super(key:key);

  final List<Map<String,String>> items;
  final callBack sendBlock;
  final String title;


  @override
  _SectionCellState createState() => _SectionCellState();
}


class _SectionCellState extends State<SectionCell> {

  List <MyFlatButton> itmeList = [];

  void pressBtn(int index){
    widget.sendBlock(index);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    int index = 0;
    for(var item in widget.items){

      MyFlatButton btn = MyFlatButton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10.0,),
            Image.asset(item['icon'],
              width: 30.0,
            ),
            Text(item['name'],style: TextStyle(fontSize: 10.0),),
            SizedBox(height: 10.0,),
          ],
        ),

        flag: index,
        onPressed: pressBtn,

      );
      index++;
      itmeList.add(btn);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0,width: double.infinity,),
        Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
        Wrap(
          children: itmeList,
        )

      ],
    );
  }
}


class MyFlatButton extends StatelessWidget {

  MyFlatButton({
    Key key,
    this.flag,
    this.child,
    this.onPressed
  });

  final int flag;
  final Widget child;
  final callBack onPressed;

  void pressFunc(){
    onPressed(this.flag);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlatButton(
      onPressed: pressFunc,
      child:child ,
    );
  }
}