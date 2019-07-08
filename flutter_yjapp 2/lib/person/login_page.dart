import 'package:flutter/material.dart';
import 'package:flutter_yjapp/config/header_config.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'register_page.dart';
import 'package:flutter_yjapp/tabbar/tabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

   return MaterialApp(
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,//若有Appbar，应根据status的颜色选择brightness
            color: Colors.transparent,
            elevation: 0,
          ),
      ),

      home: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,//若有Appbar，应根据status的颜色选择brightness
          backgroundColor: Colors.transparent,
          elevation: 0,//阴影
          actions: <Widget>[
            InkWell(
              child:Padding(
                padding:EdgeInsets.only(top: 20,right: 5.0),
                child: Text('验证码登录',style: TextStyle(color: YJColors.text_dark),),
              ),
            )
          ],
        ),

      
        body:AnnotatedRegion<SystemUiOverlayStyle>(
          sized: false,
          child: FormKeyboardActions(
            child: Login(),
          ),
          value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white
          ),
        ),

      ),

    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State <Login> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

  bool _isClick = false;
  bool _isShowPWD = true;
  bool _isHideClosePWD = true;
  bool _isHideCloseName = true;


  KeyboardActionsConfig _buildConfig(BuildContext context){
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nodeText1,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text('关闭'),
          )
        ),
        KeyboardAction(
            focusNode: _nodeText2,
          closeWidget: Padding(
              padding: EdgeInsets.all(5.0),
            child: Text('关闭'),
          )
        )
      ]
    );
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();

    if(defaultTargetPlatform==TargetPlatform.iOS){
      // 因Android平台输入法兼容问题，所以只配置IOS平台
      var config = _buildConfig(context);
      FormKeyboardActions.setKeyboardActions(context, _buildConfig(context));
    }
    
    _nameController.addListener(_verify);
    _pwdController.addListener(_verify);

    initData();

  }


  initData() async{

    SharedPreferences prefes =  await SharedPreferences.getInstance();
    String name = await prefes.getString('username');
    String pwd = await prefes.getString('pwd');
    print(name);

    _nameController.text = name;
    _pwdController.text = pwd;
  }

  void _verify(){
    String name = _nameController.text;
    String pwd = _pwdController.text;

    if(name.isNotEmpty){
      _isHideCloseName = false;
    }else{
      _isHideCloseName = true;
    }
    if(pwd.isNotEmpty){
      _isHideClosePWD = false;
    }else{
      _isHideClosePWD = true;

    }

    if(name.length==11 && pwd.length>=6){
      _isClick = true;
    }else{
      _isClick = false;
    }
    print(name + pwd);
    setState(() {

    });
  }

  void _pressLogin() async{
    print('login');
    Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context){
      return Tabbar();
    }),(router){
      return false;
    } );


    SharedPreferences prefes = await SharedPreferences.getInstance();

    String name = _nameController.text;
    await prefes.setString('username', name);

    String pwd = _pwdController.text;
    await prefes.setString('pwd', pwd);
  }

  void _seePWD(){
    setState(() {
      _isShowPWD = !_isShowPWD;
    });
  }

  //去注册
  void goRigisterPage(){
    Navigator.push(context,MaterialPageRoute(builder: (context){
      return RegisterPage();
    }));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('密码登录',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
          ) ,
          SizedBox(height: 16.0,),
          Stack(
            children: <Widget>[
              TextField(
                focusNode: _nodeText1,
                autofocus: false,
                controller: _nameController,
                decoration: new InputDecoration(
                  hintText: '请输入账号',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: YJColors.app_main,
                          width: 0.8
                      )
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: YJColors.line,
                          width: 0.8
                      )
                  ),
                  counterText: "",
                ),

                keyboardType: TextInputType.phone,
                maxLength: 11,

              ),

              Positioned(
                  right: 0,
                  top: 10.0,
                  height: 18.0,
                  width: 18.0,
                  child: Offstage(
                    offstage: _isHideCloseName,
                    child:InkWell(
                      child: Image.asset(
                        'assets/images/login/qyg_shop_icon_delete.png',
                        width: 18.0,
                        height: 18.0,
                      ),

                      onTap: (){
                        _nameController.text="";
                        _isHideCloseName = true;
                        setState(() {

                        });
                      },

                    ),
                  )
              ),

            ],
          ),

          SizedBox(height: 10.0,),


          Stack(
            children: <Widget>[
              TextField(
                focusNode: _nodeText2,
                controller: _pwdController,
                maxLength: 12,
                decoration: new InputDecoration(
                    counterText: "",
                    hintText: '请输入密码',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: YJColors.app_main,
                            width: 0.8
                        )
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: YJColors.line,
                            width: 0.8
                        )
                    )
                ),
                obscureText: _isShowPWD,
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

              Positioned(
                right: 28,
                top: 10.0,
                height: 18.0,
                width: 18.0,
                child: Offstage(
                    offstage: _isHideClosePWD,
                    child:InkWell(
                      child: Image.asset(
                        'assets/images/login/qyg_shop_icon_delete.png',
                        width: 18.0,
                        height: 18.0,
                      ),

                      onTap: (){
                        _pwdController.text="";
                        _isHideClosePWD = true;
                        setState(() {

                        });
                      },

                    ),
                )
              ),





            ],
          ),

          SizedBox(height: 20.0,),
          FlatButton(
            textColor: Colors.white,
            color: YJColors.app_main,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0)
            ),
            disabledColor: YJColors.login_button_disabled,
            disabledTextColor: YJColors.login_text_disabled,

            onPressed: _isClick ? _pressLogin:null ,

            child: Column(
              children: <Widget>[
                Container(
                  height: 44.0,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text('登录',style: TextStyle(fontSize: 16),),
                )
              ],
            ),
          ),

          //忘记密码
          Container(
            height: 40.0,
            child: InkWell(
              child: Text('忘记密码',style: TextStyle(fontSize: 12,color: YJColors.text_gray),),
              onTap: (){
                print('忘记密码');
              },
            ),
            alignment: Alignment.centerRight,
          ),
          
          //还没账号？快去注册
          Container(
            padding: EdgeInsets.only(top: 10.0),
            alignment: Alignment.center,
            child: InkWell(
              child: Text('还没账号？快去注册',style: TextStyle(color: YJColors.app_main,fontSize: 13.0),),
              onTap: goRigisterPage,
            ),
          )

        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _pwdController.dispose();
    super.dispose();
  }
}

