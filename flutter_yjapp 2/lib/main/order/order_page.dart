import 'package:flutter/material.dart';
import 'package:flutter_yjapp/utils/utils_header.dart';
import 'package:flutter_yjapp/widgets/my_card.dart';
import 'package:flutter_yjapp/widgets/my_flexible_space_bar.dart';
import 'order_search.dart';

class OrderPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return OrderBody();
  }
}

class OrderBody extends StatefulWidget {
  @override
  _OrderBodyState createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {

  int _tabSelectIndex = 0;
  List _tabCountList = [10,8,9,0,0];


  void pressSearch(){
    Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return OrderSearch();
        })
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: _sliverBuilder(),
      ),
    );
  }

  List<Widget> _sliverBuilder(){
    return <Widget>[
      SliverAppBar(
        brightness: Brightness.dark,//修改状态栏 颜色为白色
        leading: Container(),
        actions: <Widget>[
          IconButton(
            icon: loadAssetImage('order/icon_search',width: 22.0),
            onPressed: pressSearch,
          )
        ],

        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        expandedHeight: 100.0,
        floating: false,// 不随着滑动隐藏标题
        pinned: true,// 固定在顶部
        flexibleSpace: MyFlexibleSpaceBar(
          background: loadAssetImage(
            'order/order_bg', 
            width: double.infinity,
            height: 113.0,
            fit: BoxFit.fill
          ),
          
          centerTitle: true,
          titlePadding:EdgeInsetsDirectional.only(start: 16.0,bottom: 14.0) ,
          collapseMode: CollapseMode.pin,
          title: Text('订单'),
        ),


      ),


      SliverPersistentHeader(
        pinned: true ,
        delegate: MySliverPersistentHeaderDelegate(
            height:80.0,
            widget: DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(PathUtil.getImgPath('order/order_bg1')),
                      fit: BoxFit.fill

                  )
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    MyCard(
                      child: Container(
                        height: 80.0,
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _buildTabView(0, "order/xdd_s", "order/xdd_n", '新订单'),
                            _buildTabView(1, "order/dps_s", "order/dps_n", '待配送'),
                            _buildTabView(2, "order/dwc_s", "order/dwc_n", '待完成'),
                            _buildTabView(3, "order/ywc_s", "order/ywc_n", '已完成'),
                            _buildTabView(4, "order/yqx_s", "order/yqx_n", '已取消'),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),

              ),


            )
        ),
      ),

      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context,index){
              return Padding(
                padding: EdgeInsets.only(top: 10),
                child: MyCard(
                  child: index%5==0?_getTimeTag():_getItem(),
                ),
              ) ;
            },
            childCount: 50,


          ),

        ),

      )



    ];
  }


  Widget _buildTabView(int index,String selImg,String unImg,String text){

    return InkWell(
      child:Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 8.0,),
              loadAssetImage(_tabSelectIndex==index?selImg:unImg,width: 24.0,height: 24.0),
              SizedBox(height: 5.0,),
              Text(text,style: _tabSelectIndex==index?TextStyle(fontSize: 12,color: YJColors.text_dark,fontWeight: FontWeight.bold):TextStyle(fontSize: 12,color: YJColors.text_dark),),
              SizedBox(height: 8.0,),
            ],
          ),

          Positioned(
            right: 0,
            top: 0,
            child: Offstage(
              offstage: _tabCountList[index]==0,
              child: Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(
                    minWidth: 16.0,
                    minHeight: 16.0
                ),
                decoration: BoxDecoration(
                  color: YJColors.text_red,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(_tabCountList[index].toString(),style: TextStyle(color: Colors.white,fontSize: 10),),
              ),
            ),
          )

        ],
      ) ,

      onTap: (){
        setState(() {
          _tabSelectIndex = index;
        });
      },
    );
  }

  Widget _getTimeTag(){
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          loadAssetImage('order/icon_calendar',width: 12.0),
          SizedBox(width: 10,),
          Text('2019年2月5日',style: TextStyle(fontSize: 12.0,color: YJColors.text_dark),),
          Spacer(),

          Text('4单',style: TextStyle(fontSize: 12.0,color: YJColors.text_dark),),
        ],
      ),
    );
  }

  Widget _getItem(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('18614060661(朱允见)',style: TextStyle(fontSize: 12.0,color: YJColors.text_dark),),
              Text('货到付款',style: TextStyle(fontSize: 11.0,color: YJColors.text_red),)
            ],
          ),
          SizedBox(height: 10.0,),

          Text('浙江省 杭州市 余杭区 仓前街道 恒生科技园38栋',style: TextStyle(fontSize: 11.0,color: YJColors.text_gray),),
          SizedBox(height: 10.0,),
          YJUtil.line,

          Column(
            children: <Widget>[
              SizedBox(height: 5.0,),
              Text('清风抽纸 x 1',style: TextStyle(color: YJColors.text_gray,fontSize: 11.0),),
              SizedBox(height: 5.0,),
              Text('清风卷纸 x 2',style: TextStyle(color: YJColors.text_gray,fontSize: 11.0),),
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text.rich(TextSpan(
                text: '￥20.00',
                style: TextStyle(fontSize: 12.0,color: YJColors.text_gray),
                children: [
                  TextSpan(
                    text: '  共3件商品',
                    style: TextStyle(fontSize: 10,color: YJColors.text_gray_c)
                  )
                ]
              )),

              Text('2019年07月04日18:05:44',style: TextStyle(color: YJColors.text_gray,fontSize: 12.0),),
            ],
          ),

          SizedBox(height: 10.0,),
          YJUtil.line,

          Theme(
            // 修改button默认的最小宽度与padding
            data: Theme.of(context).copyWith(
              buttonTheme: ButtonThemeData(
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                minWidth: 64.0,
                height: 30.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),

              textTheme: TextTheme(
                  button: TextStyle(
                      fontSize:13.0
                  ),
              )


            ),
            child: Row(
              children: <Widget>[
                FlatButton(
                  child: Text('联系客户'),
                  color: YJColors.bg_color,
                  onPressed: ()=> pressCall('18614060661'),
                ),

                Spacer(),

                FlatButton(
                  child: Text('拒单'),
                  color: YJColors.bg_color,
                  onPressed: (){

                  },
                ),

                SizedBox(width: 10.0,),

                FlatButton(
                  child: Text('接单'),
                  color: YJColors.app_main,
                  textColor: Colors.white,
                  onPressed: (){

                  },
                )

              ],
            ),
          )

        ],
      ),
    );
  }

//  ----------------事件处理-----------------
    void pressCall(String phone){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('提示'),
            content: Text('是否拨打: $phone'),
            actions: <Widget>[
              FlatButton(
                child: Text('取消'),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),

              FlatButton(
                child: Text("确定"),
                textColor: YJColors.text_red,
                onPressed: (){
                  YJUtil.langchTelUrl(phone);
                  Navigator.pop(context);
                },
              )

            ],
          );
        }
      );
    }


}



class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate({
    this.widget,
    this.height
  });

  final double height;
  final Widget widget;

  @override
  // TODO: implement minExtent
  double get minExtent => height;

  @override
  // TODO: implement maxExtent
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return widget;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}











