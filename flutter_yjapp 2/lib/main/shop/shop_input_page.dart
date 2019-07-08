import 'package:flutter/material.dart';
import 'package:flutter_yjapp/utils/utils_header.dart';



class ShopInputPage extends StatefulWidget {

  ShopInputPage({
    Key key,
    this.title,
    this.contxt
  }):super();

  final String title;
  final String contxt;


  @override
  _ShopInputPageState createState() => _ShopInputPageState();
}




class _ShopInputPageState extends State <ShopInputPage> {

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(changeText);

    _controller.text = widget.contxt;
  }

  void changeText(){

  }

  void pressDown(){
    print('完成');
    String content = _controller.text;
    Navigator.pop(context,content);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text('${widget.title}'),
        centerTitle: false,
        leading: MyNavbar.leading(context),
        textTheme: MyNavbar.textTheme(),
        actions: <Widget>[
          FlatButton(
            child: Text('完成',style:MyNavbar.textStyleRight,),
            onPressed: pressDown,
          )
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: '请输入${widget.title}',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0,color: Colors.transparent),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 0.0,color: Colors.transparent),
              ),

            ),
            maxLength: 30,
            maxLines: 3,
            style: TextStyle(fontSize: 14.0),
            autofocus: true,
            keyboardType:TextInputType.text ,
          ),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: EdgeInsets.all(5.0),
        ),

      ),

    );
  }
}


