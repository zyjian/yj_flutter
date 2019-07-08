import 'package:flutter/material.dart';
import 'package:flutter_yjapp/config/header_config.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text('注册'),
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/ic_back_black.png',
            height: 20.0,
            width: 20.0,

          ),
          onPressed: (){
            Navigator.maybePop(context);
          }),
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.black,
            fontSize: 16.0
          ),
        ),

      ),

      body: defaultTargetPlatform==TargetPlatform.iOS?FormKeyboardActions(
        child: new RegisterContent(),
      ): RegisterContent()

    );
  }
}

//---------------自定义样式开始-------------------
class MyInputDecoration extends InputDecoration {
  MyInputDecoration({Key key,this.hintText}):super();

  final String hintText;

  @override
  // TODO: implement counterText
  String get counterText => '';

  @override
  // TODO: implement focusedBorder
  InputBorder get focusedBorder {
    return UnderlineInputBorder(
      borderSide: BorderSide(
          color: YJColors.app_main,
          width: 0.8
      ),
    );
  }

  @override
  // TODO: implement enabledBorder
  InputBorder get enabledBorder {
    return UnderlineInputBorder(
          borderSide: BorderSide(
          color: YJColors.line,
          width: 0.8
        )
    );
  }

}

class CoderView extends StatefulWidget {
  CoderView({
    Key key,
    @required this.callback,
    @required this.isCanpress,
    @required this.isCode,

  }):super(key:key);

  final VoidCallback callback;
  bool isCanpress;
  bool isCode;

  @override
  _CodeViewState createState() => new _CodeViewState();
}

class _CodeViewState extends State<CoderView>{

  Timer _timer;
  int totalNumber = 30;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    if(_timer!=null){
      _timer.cancel();

    }
    super.dispose();
  }


  void pressGetCode(){
    if(widget.isCanpress==false){
      print('正输入手机号');
      return;
    }

    widget.callback();
    widget.isCode = false;

    totalNumber = 10;
    _timer = Timer.periodic(
        Duration(seconds: 1),
        timerRunning
    );
  }

  void timerRunning(Timer timer){
    totalNumber--;
    if(totalNumber==0){
      widget.isCode = true;
      _timer.cancel();
    }
    setState(() {
    });
    print(totalNumber);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.isCode ? InkWell(
      child: Container(
        alignment: Alignment.center,
        height: 25.0,
        width: 68.0,
        child: Text('获取验证码',style: TextStyle(color: YJColors.app_main,fontSize: 12.0)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1.0),
            border: Border.all(color: YJColors.app_main,width: 0.8)
        ),
      ),

      onTap: pressGetCode,
    ) : Container(
      alignment: Alignment.center,
      height: 25.0,
      width: 68.0,
      child: Text('(${totalNumber}s)',style: TextStyle(color:Colors.white,fontSize: 12.0)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.0),
        color: Colors.grey[400],
      ),

    );
  }
}


//---------------自定义样式结束-------------------


class RegisterContent extends StatefulWidget {

  @override
  _RegisterContentState createState() => new _RegisterContentState();
}

class _RegisterContentState extends State<RegisterContent>{
  TextEditingController _nameController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  FocusNode _node1 = FocusNode();
  FocusNode _node2 = FocusNode();
  FocusNode _node3 = FocusNode();

  bool _hideCloseName = true;
  bool _hideColseCode = true;
  bool _hideColsePwd = true;

  bool _isClick = false;

  bool _isCode = true;
  bool _isCanPressCode = false;
  bool _isShowPWD = true;

  void pressGetCode(){
    print('发送验证码');
    FocusScope.of(context).requestFocus(_node2);
    Future.delayed(Duration(seconds: 2),(){

      //获取短信接口成功
      _isCode = false;

      //获取短信接口失败
//      _isCode = true;

      setState(() {

      });
    });

  }


  KeyboardActionsConfig _buildKeyConfig(){
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        actions: [
          KeyboardAction(
              focusNode:_node1,
              closeWidget:Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('关闭'),
              )
          ),
          KeyboardAction(
              focusNode:_node2,
              closeWidget:Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('关闭'),
              )
          ),
          KeyboardAction(
              focusNode:_node3,
              closeWidget:Padding(
                padding: EdgeInsets.all(5.0),
                child: Text('关闭'),
              )
          ),
        ]
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(defaultTargetPlatform == TargetPlatform.iOS){
      FormKeyboardActions.setKeyboardActions(context, _buildKeyConfig());
    }

    _nameController.addListener(_verify);
    _codeController.addListener(_verify);
    _pwdController.addListener(_verify);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _codeController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  void _verify(){
    print('_verify');

    String name = _nameController.text;
    String code = _codeController.text;
    String pwd = _pwdController.text;

    _hideCloseName = name.isEmpty;
    _hideColseCode = code.isEmpty;
    _hideColsePwd = pwd.isEmpty;

    if(name.length==11){
      _isCanPressCode = true;
    }else{
      _isCanPressCode = false;
    }

    if(name.length==11&&code.length==6&&pwd.length>=6){
      _isClick = true;
    }else{
      _isClick = false;
    }

    setState(() {

    });
  }

  void _seePWD(){
    setState(() {
      _isShowPWD = !_isShowPWD;
    });
  }

  //点击确认
  void pressDown(){

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Padding(
      padding: EdgeInsets.only(left: 10.0,right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0,),
          Text('开启你的账号',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),

          SizedBox(height: 10.0,),

          Stack(
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.phone,
                decoration: MyInputDecoration(
                  hintText: '请输入账号',
                ),
                maxLength: 11,
                focusNode: _node1,
                controller: _nameController,
                autofocus: true,
              ),

              Positioned(
                right: 0,
                top: 10,
                width: 18.0,
                height: 18.0,
                child: Offstage(
                  offstage: _hideCloseName,
                  child: InkWell(
                    child: Image.asset('assets/images/login/qyg_shop_icon_delete.png',
                      width: 18.0,
                      height: 18.0,
                    ),
                    onTap: (){
                      _nameController.text = '';
                    },
                  ),
                ),
              )

            ],
          ),

          SizedBox(height: 10.0,),

          Stack(
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.phone,
                decoration: MyInputDecoration(
                  hintText: '请输入验证码',
                ),
                maxLength: 6,
                focusNode: _node2,
                controller: _codeController,

              ),

              Positioned(
                right: 80,
                top: 10,
                width: 18.0,
                height: 18.0,
                child: Offstage(
                  offstage: _hideColseCode,
                  child: InkWell(
                    child: Image.asset('assets/images/login/qyg_shop_icon_delete.png',
                      width: 18.0,
                      height: 18.0,
                    ),
                    onTap: (){
                      _codeController.text = '';
                    },
                  ),
                ),
              ),

              Positioned(
                right: 0,
                top: 8,
                width: 68,
                child: new CoderView(
                  isCode: _isCode,
                  isCanpress: _isCanPressCode,
                  callback: pressGetCode,
                )

              )



            ],
          ),


          SizedBox(height: 10.0,),

          Stack(
            children: <Widget>[
              TextField(
                decoration: MyInputDecoration(
                  hintText: '请输入密码',
                ),
                maxLength: 12,
                obscureText: _isShowPWD,
                focusNode: _node3,
                controller: _pwdController,

              ),

              Positioned(
                right: 28,
                top: 10,
                width: 18.0,
                height: 18.0,
                child: Offstage(
                  offstage: _hideColsePwd,
                  child: InkWell(
                    child: Image.asset('assets/images/login/qyg_shop_icon_delete.png',
                      width: 18.0,
                      height: 18.0,
                    ),
                    onTap: (){
                      _pwdController.text = '';
                    },
                  ),
                ),
              ),

              Positioned(
                right: 0,
                top: 10.0,
                height: 18.0,
                width: 18.0,
                child: InkWell(
                  child: Image.asset(
                    _isShowPWD==false?'assets/images/login/qyg_shop_icon_display.png':'assets/images/login/qyg_shop_icon_hide.png',
                    width: 18.0,
                    height: 18.0,
                  ),

                  onTap: _seePWD,
                ),
              ),

            ],
          ),

          SizedBox(height: 20.0,),

          FlatButton(
            child: Container(
              alignment: Alignment.center,
              child: Text('确认',style: TextStyle(fontSize: 16.0),),
              height: 44.0,
            ),
            color: YJColors.app_main,
            textColor: Colors.white,

            disabledTextColor: YJColors.login_text_disabled,
            disabledColor: YJColors.login_button_disabled,

            onPressed: _isClick ? pressDown : null,

          )



        ],
      ),
    );
  }
}