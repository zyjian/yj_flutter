import 'package:flutter/material.dart';
import 'package:flutter_yjapp/utils/utils_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class NoticePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text('消息'),
        centerTitle: true,
        textTheme: MyNavbar.textTheme(),
        leading: MyNavbar.leading(context),
        actions: <Widget>[
          FlatButton(
            child: Text('全部已读',style: TextStyle(color: YJColors.text_dark,fontSize: 12.0),),
          )
        ],
      ),

      body: Padding(
          padding:EdgeInsets.symmetric(horizontal: 20.0),
        child: NoticeBody(),
      ),

    );
  }
}

class NoticeBody extends StatefulWidget {
  @override
  _NoticeBodyState createState() => new _NoticeBodyState();
}

class _NoticeBodyState extends State<NoticeBody>{
  
  GlobalKey <EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey <RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();


  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return EasyRefresh(
        key: _easyRefreshKey,
        onRefresh: ()async{
          print('refeash');
          await Future.delayed(Duration(seconds: 2));
        },
        loadMore: ()async{
          print('loadMore');
          await Future.delayed(Duration(seconds: 2));

        },
        behavior: ScrollOverBehavior(),
        refreshHeader: ClassicsHeader(
          key: _headerKey,
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
          showMore: true,
        ),
        refreshFooter: ClassicsFooter(
          key: _footerKey,
          showMore: true,
          bgColor: Colors.transparent,
          textColor: Colors.black87,
          moreInfoColor: Colors.black54,
        ),

        child: ListView.builder(
          itemBuilder: (BuildContext context,int index){
            return Column(
              children: <Widget>[
                Text('2019-5-21 17:18:00',style: TextStyle(color: YJColors.text_gray,fontSize: 10.0),),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                  width: double.infinity,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x80DCE7FA),
                            blurRadius: 8.0,
                            offset: Offset(-5, 5)

                        ),
                      ]

                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flex(
                        direction:Axis.horizontal,
                        children: <Widget>[
                          Text('系统通知',style: TextStyle(fontSize: 14.0,color: YJColors.text_normal),),
                          Spacer(flex: 1,),
                          Container(
                            child: SizedBox(height: 8,width: 8,),
                            decoration: BoxDecoration(
                              color: YJColors.app_main,
                              borderRadius: BorderRadius.circular(4.0),

                            ),
                          ),
                          MyCell.rightArrowImg()
                        ],
                      ),
                      Divider(color: YJColors.line,),
                      Text('供货商由于【商品缺货】原因，取消了采购订单]',style: TextStyle(fontSize: 12.0,color: YJColors.text_normal),),
                    ],
                  ),
                ),

                SizedBox(height: 15.0,),

              ],
            );
          },
          itemCount: 10,
        )
    );

  }
}