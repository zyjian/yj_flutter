import 'package:flutter/material.dart';
import 'package:flutter_yjapp/utils/utils_header.dart';
import 'shop_input_page.dart';
import 'pay_type_dialog.dart';
import 'freight_type_dialog.dart';
import 'input_dialog.dart';

class ShopSettingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      // 防止键盘弹出，提交按钮升起。。。
    resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        leading: MyNavbar.leading(context),
      ),

      body: ShopSettingBody(),

    );
  }
}

class MyTextStyle {
  static TextStyle gray13 = TextStyle(fontSize: 13,color: YJColors.text_gray);
  static TextStyle black13 = TextStyle(fontSize: 13,color: YJColors.text_dark);
  static TextStyle sectionStyle = TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold);
}

class ShopSetModel extends Object{
  String name='';
  String service='';
  String payWay='';

  String freightConfig='';
  double freigtFullSubtract=0;
  double freightFree=0;

  String phone='';
  String address='';

}

class ShopSettingBody extends StatefulWidget {
  @override
  _ShopSettingBodyState createState() => new _ShopSettingBodyState();
}

class _ShopSettingBodyState extends State <ShopSettingBody> {

  bool _isOpening = true;
  ShopSetModel _shopSetModel;

  List _list = [
    {
      'name':'线上支付',
      'flag':true,
    },
    {
      'name':'对公转账',
      'flag':false,
    },
    {
      'name':'货到付款',
      'flag':false,
    }];

  List<String> freight_items = ['运费满免配置','运费比例配置'];
  int _freight_selectIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _shopSetModel = ShopSetModel();
    loadData();
  }

  void loadData() async{

    //模拟网络请求
    Future.delayed(Duration(seconds: 2),(){
      _shopSetModel = ShopSetModel();

      _shopSetModel.name = '零食良品铺子旗舰店零食良品铺子旗舰店零食良品铺子旗舰店';
      _shopSetModel.service = '假一赔十';
      _shopSetModel.payWay = '在线支付';

      _shopSetModel.freightConfig = '运费满减配置';
      _shopSetModel.freigtFullSubtract = 0.0;
      _shopSetModel.freightFree = 0.0;

      _shopSetModel.phone = '18614060661';
      _shopSetModel.address = '浙江省 杭州市 余杭区 仓前街道 文一西路 恒生科技园38栋';

      setState(() {

      });
    });
  }

  Future<String> goInputShop(String title,String contxt) async{
    String content = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
      return ShopInputPage(title: title,contxt: contxt,);
    }));
    print(content);
    return content;
  }

  void pressList(int section,int row) async{
    print('section = $section  ,row = $row');
    if(section==0){
      if(row==0){
        //店铺简介
        String content = await goInputShop('店铺简介',_shopSetModel.name);
        if(content != null){
          _shopSetModel.name = content;
          setState(() {

          });
        }

      }else if(row==1){
        //保障服务
        String content = await goInputShop('保障服务',_shopSetModel.service);
        if(content != null){
          _shopSetModel.service = content;
          setState(() {

          });
        }
      }else if(row==2){
         var res = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context){
              return PayTypeDialog(items: _list,);
            }
          );
         String payWay = '';
         for(var dic in _list){
           if(dic['flag']==true){
             payWay = '$payWay+${dic['name']}';
           }
         }

         payWay = payWay.substring(1);

         _shopSetModel.payWay = payWay;
         setState(() {

         });

      }
    }else if(section==1){
      if(row==0){
        //运费配置
        var res = await showDialog(
              context: context,
            barrierDismissible: false,
            builder: (BuildContext context){
                return FreightTypeDialog(items: freight_items, selectIndex: _freight_selectIndex);
            }
          );
        print('运费配置: $res');
        if(res==null){
          return;
        }

        _freight_selectIndex = res;
        _shopSetModel.freightConfig = freight_items[_freight_selectIndex];
        setState(() {

        });

      }else if (row==1){
        //运费满减
        var res = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return InputDialog(title: '配送费满免',textValue: _shopSetModel.freigtFullSubtract,);
          }
        );
        print('运费满减: $res');
        if(res!=null){
          _shopSetModel.freigtFullSubtract = res;
          setState(() {

          });
        }

      }else if(row==2){
        //配送费用
        var res = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context){
              return InputDialog(title: '配送费用',textValue: _shopSetModel.freightFree,);
            }
        );
        print('配送费用: $res');
        if(res!=null){
          _shopSetModel.freightFree = res;
          setState(() {

          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 0,bottom: 50.0),
          child: ListView(
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_isOpening ? '正在营业':'暂停营业',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

                  Switch.adaptive(value: _isOpening, onChanged: (bool flag){
                    _isOpening = !_isOpening;
                    setState(() {

                    });
                  }),
                ],
              ),

              SizedBox(height: 20.0,),

              Text('基础设置',style: MyTextStyle.sectionStyle,),
              InkWell(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0,),

                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Text('店铺简介',style: MyTextStyle.black13,),

                        Spacer(
                          flex: 1,
                        ),

                        Container(
                          width: 200,
                          child:Text(_shopSetModel.name,style: MyTextStyle.gray13,overflow: TextOverflow.ellipsis,maxLines: 1,textAlign: TextAlign.right,) ,
                        ),


                        MyCell.rightArrowImg(),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Divider(height: 0.8,color: YJColors.line,)
                  ],
                ),
                onTap: (){
                  pressList(0, 0);
                },
              ),

              InkWell(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0,),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Text('保障服务',style: MyTextStyle.black13,),

                        Spacer(
                          flex: 1,
                        ),

                        Text(_shopSetModel.service,style: MyTextStyle.gray13,),

                        MyCell.rightArrowImg(),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Divider(height: 0.8,color: YJColors.line,)
                  ],
                ),
                onTap: (){
                  pressList(0, 1);
                },
              ),

              InkWell(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0,),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Text('支付方式',style: MyTextStyle.black13,),

                        Spacer(
                          flex: 1,
                        ),

                        Text(_shopSetModel.payWay,style: MyTextStyle.gray13,),

                        MyCell.rightArrowImg(),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Divider(height: 0.8,color: YJColors.line,)
                  ],
                ),
                onTap: (){
                  pressList(0, 2);
                },
              ),



              SizedBox(height: 20.0,),
              Text('运费方式',style: MyTextStyle.sectionStyle,),
              InkWell(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0,),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Text('运费配置',style: MyTextStyle.black13,),

                        Spacer(
                          flex: 1,
                        ),

                        Text(_shopSetModel.freightConfig,style: MyTextStyle.gray13,),

                        MyCell.rightArrowImg(),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Divider(height: 0.8,color: YJColors.line,)
                  ],
                ),
                onTap: (){
                  pressList(1, 0);
                },
              ),

              _freight_selectIndex==0?
              Column(
                children: <Widget>[
                  InkWell(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15.0,),
                        Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Text('运费满免',style: MyTextStyle.black13,),

                            Spacer(
                              flex: 1,
                            ),

                            Text(_shopSetModel.freigtFullSubtract.toStringAsFixed(2),style: MyTextStyle.gray13,),

                            MyCell.rightArrowImg(),
                          ],
                        ),
                        SizedBox(height: 15.0,),
                        Divider(height: 0.8,color: YJColors.line,)
                      ],
                    ),
                    onTap: (){
                      pressList(1, 1);
                    },
                  ),

                  InkWell(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15.0,),
                        Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Text('配送费用',style: MyTextStyle.black13,),

                            Spacer(
                              flex: 1,
                            ),

                            Text(_shopSetModel.freightFree.toStringAsFixed(2),style: MyTextStyle.gray13,),

                            MyCell.rightArrowImg(),
                          ],
                        ),
                        SizedBox(height: 15.0,),
                        Divider(height: 0.8,color: YJColors.line,)
                      ],
                    ),
                    onTap: (){
                      pressList(1, 2);
                    },
                  ),
                ],
              ):
              Column(
                children: <Widget>[
                  InkWell(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15.0,),
                        Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('运费比例',style: MyTextStyle.black13,),

                            Spacer(
                              flex: 1,
                            ),

                            Container(
                              width: 200,
                              child:Text('1、订单金额<20元，配送费为订单的1%\n2、订单金额>=20元，配送为订单0.5%',style: MyTextStyle.gray13,overflow: TextOverflow.ellipsis,maxLines: 4,) ,
                            ),

                            MyCell.rightArrowImg(),
                          ],
                        ),
                        SizedBox(height: 15.0,),
                        Divider(height: 0.8,color: YJColors.line,)
                      ],
                    ),
                    onTap: (){
                      pressList(1, 3);
                    },
                  ),
                ],
              )
              ,


              SizedBox(height: 20.0,),
              Text('联系信息',style: MyTextStyle.sectionStyle,),
              InkWell(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0,),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Text('联系电话',style: MyTextStyle.black13,),

                        Spacer(
                          flex: 1,
                        ),

                        Text(_shopSetModel.phone,style: MyTextStyle.gray13,),

                        MyCell.rightArrowImg(),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Divider(height: 0.8,color: YJColors.line,)
                  ],
                ),
                onTap: (){
                  pressList(2, 0);
                },
              ),

              InkWell(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0,),
                    Flex(
                      direction: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('店铺地址',style: MyTextStyle.black13,),

                        Spacer(
                          flex: 1,
                        ),

                        Container(
                          height: 35.0,
                          width: 200,
                          child:Text(_shopSetModel.address,style: MyTextStyle.gray13,overflow: TextOverflow.ellipsis,maxLines: 2,) ,
                        ),

                        MyCell.rightArrowImg(),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Divider(height: 0.8,color: YJColors.line,)
                  ],
                ),
                onTap: (){
                  pressList(2, 1);
                },
              ),


            ],
          ),
        ),


        Positioned(
          left: 10,
          right: 10.0,
          bottom: 2.5,
          child: Container(
            height: 45.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: YJColors.app_main,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: FlatButton(
              onPressed: (){},
              child: Text('提交',style: TextStyle(color: Colors.white,fontSize: 18.0),),
            ),
          ),
        )

      ],
    );
  }
}




