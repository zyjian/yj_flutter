import 'package:flutter/material.dart';
import 'package:flutter_yjapp/utils/utils_header.dart';
import 'package:flutter_yjapp/config/header_config.dart';
import 'package:sticky_headers/sticky_headers.dart';

class AcountRecoderPage extends StatefulWidget {
  @override
  _AcountRecoderPageState createState() => _AcountRecoderPageState();
}

class _AcountRecoderPageState extends State <AcountRecoderPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: MyNavbar.leading(context),
        title: Text('账户流水',style: TextStyle(color: YJColors.text_dark),),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return new StickyHeader(
          header: new Container(
            color: YJColors.bg_color,
            height: 30.0,
            padding: new EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: new Text('2019/07/$index',
              style: const TextStyle(color: Colors.black),
            ),
          ),
          content: Padding(padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildContent(index),
          ),
        );
        },
        itemCount: 7,

      ),
    );
  }

   Widget _buildContent(int index){
    List<Widget> _widgets = [];
    for(int i=0;i<=index;i++){
      Column column = Column(
          children: <Widget>[
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('提现'),
                Text('+100.00',style: TextStyle(color: YJColors.text_red),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('18:20:09'),
                Text('余额：200.00')
              ],
            ),

            SizedBox(height: 10.0,),
            YJUtil.line,

          ],
        );

      _widgets.add(column);
    }

    return Column(
      children: _widgets,
    );
  }

}





























