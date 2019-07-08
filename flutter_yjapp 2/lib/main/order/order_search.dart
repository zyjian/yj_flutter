import 'package:flutter/material.dart';
import 'package:flutter_yjapp/utils/utils_header.dart';
import 'package:flutter_yjapp/widgets/search_bar.dart';

class OrderSearch extends StatefulWidget {
  @override
  _OrderSearchState createState() => _OrderSearchState();
}

class _OrderSearchState extends State<OrderSearch> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: SearchBar(
        backgroundColor: Colors.transparent,
        hintText: '请输入手机号或姓名查询',
        onPress: (searchStr){

        },
      ),

      body: Container(),
    );
  }
}
