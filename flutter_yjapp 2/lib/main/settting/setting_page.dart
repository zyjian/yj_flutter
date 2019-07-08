import 'package:flutter/material.dart';
import 'package:flutter_yjapp/config/header_config.dart';
import 'package:flutter_yjapp/utils/utils_header.dart';
import 'package:flutter_yjapp/person/login_page.dart';


class SettingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(
      appBar: new AppBar(
        title: Text('设置'),
        leading: MyNavbar.leading(context),
        centerTitle: true,
        textTheme: MyNavbar.textTheme(),

      ),
      body: SettingBody(),
    );
  }
}

class SettingBody extends StatefulWidget {
  @override
  _SettingBodyState createState() => _SettingBodyState();
}
class _SettingBodyState extends State <SettingBody> {
  var items = [];

  double cachSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    items = [
      '账号管理',
      '清除缓存',
      '检查更新',
      '关于我们',
      '退出当前账号'
    ];

    cachSize = 23.5;
  }

  void cellClick(int index){
    print(items[index]);


    if(index==4){
      //退出登录
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context){
        return LoginPage();
      }), (route){
        print(route);
        return route == null;
      });

    }else{
      Toast.show(items[index]);
    }

  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget divider = Divider(color: YJColors.line,);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.separated(
            itemBuilder: (BuildContext context ,int index){
              if(index==5){
                return SizedBox(height: 1,);
              }
              return GestureDetector(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(items[index],style: TextStyle(fontSize: 13.0),),

                      index==1?Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('${cachSize}MB',style: TextStyle(color: YJColors.text_gray,fontSize: 12.0),),
                          SizedBox(width: 5.0,),
                          MyCell.rightArrowImg()
                        ],
                      ):MyCell.rightArrowImg(),


                    ],
                  ),
                ),
                onTap: () => cellClick(index),
                behavior: HitTestBehavior.opaque,
              );
            },
            separatorBuilder: (BuildContext context ,int index){
              return divider;
            },
            itemCount: 6,
        )
    );
  }
}