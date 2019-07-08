import 'package:flutter/material.dart';
import 'package:flutter_yjapp/utils/utils_header.dart';
import 'package:flutter_yjapp/widgets/menu_reveal.dart';

class GoodMode{
  String name='';
  bool isLiJian = false;
  bool isKoujian = false;
  String imgscr = '';
  double price = 0.0;
  String typeName = '';
}


class SubOfPageView extends StatefulWidget {
  SubOfPageView({
    Key key,
    @required this.type
  }):super(key:key);

  final int type;
  @override
  _SubOfPageViewState createState() => _SubOfPageViewState();
}
class _SubOfPageViewState extends State<SubOfPageView> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin<SubOfPageView>{

  List<GoodMode> _list = [];
  AnimationController _animationController;
  Animation<double>_animation;
  int _selectIndex = -1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initAnmate();
    loadData();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  void initAnmate(){
    // 初始化动画控制
    _animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 450));

    // 动画曲线
    CurvedAnimation _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeOutSine);
    _animation = new Tween(begin: 0.0,end: 1.1).animate(_curvedAnimation);

  }

  void loadData(){
    int count = 0;
    if(widget.type==100){
      count=3;
    }else if(widget.type==101){
      count = 15;
    }else{
      count = 26;
    }

    List<String> _imgList = [
      "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3130502839,1206722360&fm=26&gp=0.jpg",
      "xxx", // 故意使用一张错误链接
      "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1762976310,1236462418&fm=26&gp=0.jpg",
      "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3659255919,3211745976&fm=26&gp=0.jpg",
      "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2085939314,235211629&fm=26&gp=0.jpg",
      "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2441563887,1184810091&fm=26&gp=0.jpg"
    ];
    for(int i=0;i<count;i++){
      GoodMode goodMode = GoodMode();
      goodMode.name = '中秋礼盒 八月十五 中秋礼盒 八月十五中秋礼盒 八月十五中秋礼盒 八月十五中秋礼盒 八月十五中秋礼盒 八月十五第$i';
      goodMode.imgscr = _imgList[i%_imgList.length];
      goodMode.isLiJian = i%2==0?true:false;
      goodMode.isKoujian = i%3==0?true:false;
      goodMode.price = 20+i.toDouble();
      goodMode.typeName = '特产美味$i';
      _list.add(goodMode);
    }

  }


  void pressEidte(int index){
    print('点击... $index');
    // 开始执行动画
    _animationController.forward(from: 0.0);
    setState(() {
      _selectIndex = index;
    });
  }

  void deleteItem(int index){
    print('删除');
    Navigator.pop(context);
    _list.removeAt(index);
    setState(() {

    });
  }
  
  void _showDeleteBottomSheet(int index){
    showModalBottomSheet(
        context: context, 
        builder: (BuildContext context){
          return Material(
            color: Colors.white,
            child: SafeArea(
              child: Container(
                height: 161.2,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text('是否确认删除，防止错误操作'),
                    ),

                    YJUtil.line,

                    InkWell(
                      child: Container(
                        height: 50.0,
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text('确认删除',style: TextStyle(color: YJColors.text_red,fontSize: 16.0),),
                      ),
                      onTap:()=>deleteItem(index) ,
                    ),


                    YJUtil.line,

                    InkWell(
                      child: Container(
                        height: 50.0,
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text('取消',style: TextStyle(color: YJColors.text_gray,fontSize: 16.0),),
                      ),
                      onTap: (){
                        print('取消');
                        Navigator.pop(context);

                      },
                    ),



                  ],
                )
              ),
              
            ),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(

      itemCount: _list.length,
      itemBuilder: (BuildContext context ,int index){

        GoodMode _goodmode = _list[index];

        return Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0,),
                  Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    children: <Widget>[

                      loadNetworkImage(
                        _goodmode.imgscr,
                        width: 78.0,
                        height: 78.0,
                      ),

                      SizedBox(width: 8.0,),

                      Expanded(
                        child: Container(
                          height: 78.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(_goodmode.name,style: TextStyle(fontSize: 13.0,color: YJColors.text_dark),maxLines: 1,overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 5.0,),
                              Row(
                                children: <Widget>[
                                  Offstage(
                                    offstage: _goodmode.isLiJian!=true,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 5.0),

                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: YJColors.text_red,
                                          borderRadius: BorderRadius.circular(2.0),
                                        ),
                                        padding: EdgeInsets.all(1.5),
                                        alignment: Alignment.center,

                                        child: Text('立减',style: TextStyle(fontSize: 8.0,color: Colors.white),),
                                      ),
                                    ),
                                  ),

                                  Offstage(
                                    offstage: _goodmode.isKoujian!=true,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: YJColors.app_main,
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      padding: EdgeInsets.all(1.5),
                                      alignment: Alignment.center,

                                      child: Text('社区币抵扣',style: TextStyle(fontSize: 8.0,color: Colors.white),),
                                    ),
                                  ),

                                ],
                              ),

                              Spacer(
                                flex: 1,
                              ),

                              Text('￥${_goodmode.price.toStringAsFixed(2)}',style: TextStyle(fontSize: 12.0,color: YJColors.text_dark),)


                            ],
                          ),
                        ),
                      ),

                      Container(
                        width: 80.0,
                        height: 78.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              child: loadAssetImage('goods/ellipsis',width: 15.0),
                              onTap: ()=> pressEidte(index),
                            ),
                            Text(_goodmode.typeName,style: TextStyle(fontSize: 11.0,color: YJColors.text_gray),),
                          ],
                        ),
                      )



                    ],
                  ),

                  SizedBox(height: 10.0,),
                  Divider(height: 0.6,color: YJColors.line,),

                ],
              )

              ,
            ),

            Positioned.fill(
              child: Offstage(
                offstage: _selectIndex != index,
                child: AnimatedBuilder(
                    animation: _animation,
                    builder: (_,child){
                      return MenuReveal(
                        revealPercent: _animation.value,
                        child: InkWell(
                          onTap: (){
                            _animationController.reverse(from: 1.1);
                            _selectIndex = -1;
                          },
                          child: Container(
                            color: Color(0x4D000000),
                            child:Theme(
                                data: Theme.of(context).copyWith(
                                  buttonTheme: ButtonThemeData(
                                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                                    minWidth: 56.0,
                                    height: 56.0,
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,// 距顶部距离为0
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28.0),
                                    )
                                  ),
                                  textTheme: TextTheme(
                                    button: TextStyle(fontSize: 16.0),
                                  )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    SizedBox(width: 10.0,),
                                    FlatButton(
                                      textColor: Colors.white,
                                      color: YJColors.app_main,
                                      onPressed: (){
                                        _animationController.reverse(from: 1.1);
                                        _selectIndex = -1;

                                      },
                                      child: Text('编辑'),
                                    ),

                                    FlatButton(
                                      color: Colors.white,
                                      child: Text("下架"),
                                      onPressed: (){
                                        Toast.show("下架");
                                      },
                                    ),
                                    FlatButton(
                                      color: Colors.white,
                                      child: Text("删除"),
                                      onPressed: (){
                                        _animationController.reverse(from: 1.1);
                                        _selectIndex = -1;
                                        _showDeleteBottomSheet(index);
                                      },
                                    ),
                                    SizedBox(width: 10.0,),

                                  ],
                                )
                            ) ,

                          ),
                        ),
                      );
                    }
                ),
              ),

            )

          ],
        );
      },

    );
  }


}


