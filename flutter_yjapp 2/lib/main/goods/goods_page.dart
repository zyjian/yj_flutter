import 'package:flutter/material.dart';
import 'package:flutter_yjapp/config/header_config.dart';
import 'goods_list.dart';
import 'package:flutter_yjapp/widgets/popup_window.dart';
import 'package:flutter_yjapp/utils/utils_header.dart';

class GoodsPage extends StatelessWidget {

  GlobalKey _addKey = GlobalKey();

  @override
  Widget build(BuildContext context) {


    //显示添加菜单
    void _showAddMenu(){

      final RenderBox button = _addKey.currentContext.findRenderObject();
      final RenderBox overlay = Overlay.of(context).context.findRenderObject();

      var a = button.localToGlobal(Offset(button.size.width - 8.0, button.size.height - 12.0),ancestor: overlay);
      var b =  button.localToGlobal(button.size.bottomLeft(Offset(0, - 12.0)), ancestor: overlay);



      final RelativeRect position = RelativeRect.fromRect(
        Rect.fromPoints(a, b),
        Offset.zero & overlay.size,
      );

      showPopupWindow(
        context: context,
        fullWidth: false,
        isShowBg: true,
        position: position,
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: loadAssetImage('goods/jt',width: 8.0,height: 4.0),
            ),

            Container(
              width: 120.0,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),

              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 40.0,
                    child: FlatButton.icon(
                        onPressed: (){
                          print('扫码添加');
                          Navigator.pop(context);
                        },
                        icon: loadAssetImage('goods/scanning',width: 16.0,height: 16.0),
                        label: Text("扫码添加", style: TextStyle(fontSize: 14.0,color: YJColors.text_dark),)
                    ),
                  ),
                  YJUtil.line,
                  Container(
                    height: 40.0,
                    child: FlatButton.icon(
                        onPressed: (){
                          print('添加商品');
                          Navigator.pop(context);
                        },
                        icon: loadAssetImage('goods/add2',width: 16.0,height: 16.0),
                        label: Text("添加商品", style: TextStyle(fontSize: 14.0,color: YJColors.text_dark),)
                    ),
                  ),
                ],
              ),
            )


          ],
        ),
      );
    }




    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,

        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/images/goods/search.png',width: 24.0,),
            onPressed: (){
              
            },
          ),
          
          IconButton(
            key: _addKey,
            icon: Image.asset('assets/images/goods/add.png',width: 24.0,),
            onPressed: _showAddMenu,
          ),

        ],
      ),
      
      

      body: Container(
        color: Colors.white,
        child: GoodsPageBody(),
      ),
    );

  }
}

class GoodsPageBody extends StatefulWidget {

  @override
  _GoodsPageBodyState createState() => _GoodsPageBodyState();
}

class _GoodsPageBodyState extends State<GoodsPageBody> with SingleTickerProviderStateMixin {
  List<String> _sortList = ["全部商品", "个人护理", "饮料", "沐浴洗护", "厨房用具", "休闲食品", "生鲜水果", "酒水", "家庭清洁"];
  var _sortIndex = 0;

  List tabs = ['在售','待售','下架'];
  List<String> _countList= ['3件','15件','26件'];

  TabController _tabController;
  PageController _pageController;

  GlobalKey _zhankaiKey = GlobalKey();
  GlobalKey _bodyKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(length: tabs.length, vsync: this);
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  void changeIndexTab(int index){

    print('_tabController : ${ _tabController.index}');
    _pageController.jumpToPage(_tabController.index);

    setState(() {
      
    });
  }
  void pageChanged(int index){
    print('pageChanged = $index');
    _tabController.animateTo(index);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List <Widget> _widgets = [];
    for(int i=0;i<tabs.length;i++){
      Widget _widget = Tab(
        child: Container(
          width: 78.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(tabs[i],),
              
              Offstage(
                offstage: _tabController.index==i?false:true,
                child: Text('(${_countList[i]})',style: TextStyle(fontSize: 12.0),),
              )
              
            ],
          ),
        ),
      );

      _widgets.add(_widget);

    }

    return Column(
      key: _bodyKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(_sortList[_sortIndex],style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
                SizedBox(width: 5.0,),
                Image.asset('assets/images/goods/expand.png',width: 18.0,)
              ],
            ),
          ),
          onTap: _showHeaderMenu,
          key: _zhankaiKey,
        ),

        SizedBox(height: 20.0,),

        TabBar(
          onTap: changeIndexTab,
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
          isScrollable: true,
          labelPadding: EdgeInsets.only(left: 12.0),
          unselectedLabelColor: YJColors.text_dark,
          labelColor: YJColors.app_main,
          indicatorPadding: const EdgeInsets.only(left: 12.0, right: 36.0),
          indicatorColor: YJColors.app_main,
          indicatorWeight: 2.0,
          indicatorSize: TabBarIndicatorSize.tab,

          tabs: _widgets,
        ),
        Divider(height: 0.8,color: YJColors.line,),

        Expanded(
          child: PageView(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            onPageChanged: pageChanged,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              SubOfPageView(type: 100,),
              SubOfPageView(type: 101,),
              SubOfPageView(type: 102,)
            ],
          ),
        ),

      ],
    );
  }


  void _showHeaderMenu(){
    // 获取点击控件的坐标
    final RenderBox zhankaiBtn = _zhankaiKey.currentContext.findRenderObject();
    print(zhankaiBtn.size);

    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    print(overlay.size);

    var a = zhankaiBtn.localToGlobal(Offset(0, zhankaiBtn.size.height + 10.0),ancestor: overlay);
    print('a : $a');
    var b = zhankaiBtn.localToGlobal(zhankaiBtn.size.bottomRight(Offset(0, 10)),ancestor: overlay);
    print('b : $b');

    final RelativeRect position = RelativeRect.fromRect(Rect.fromPoints(a, b),Offset.zero & overlay.size,);

    print(position);

    print('---');
    print(Rect.fromPoints(a, b));
    print(Offset.zero & overlay.size);

    final RenderBox body = _bodyKey.currentContext.findRenderObject();
    print('body :${body.size}');


    showPopupWindow(
        fullWidth: true,
        position: position,
        elevation: 0.0,
        context: context,
        child: Container(
          height: body.size.height -zhankaiBtn.size.height - 10,
          color: Color(0x99000000),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.white,
                  child:ListView.builder(
                    itemCount: _sortList.length,
                    itemBuilder: (BuildContext context,int index){
                      return ListTile(
                        title: Text(_sortList[index],style: TextStyle(fontSize: 12.0,color: _sortIndex==index?YJColors.app_main:YJColors.text_dark),),
                        trailing: Text('($index)',style: TextStyle(fontSize: 12,color: _sortIndex==index?YJColors.app_main:YJColors.text_dark),),
                        onTap: (){
                          setState(() {
                            _sortIndex = index;
                            Navigator.pop(context);

                          });
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 100.0,),
            ],
          ),
        )
    );

  }
}

