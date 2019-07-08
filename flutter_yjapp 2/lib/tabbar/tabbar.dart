import 'package:flutter/material.dart';
import 'package:flutter_yjapp/config/header_config.dart';
import 'package:flutter_yjapp/main/order/order_page.dart';
import 'package:flutter_yjapp/main/shop/shop_page.dart';
import 'package:flutter_yjapp/main/statistic/statistic_page.dart';
import 'package:flutter_yjapp/main/goods/goods_page.dart';

class Tabbar extends StatefulWidget {

  @override
  _TabbarState createState() => new _TabbarState();
}

class _TabbarState extends State <Tabbar> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  var _pageList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageList = [
      OrderPage(),
      GoodsPage(),
      StatisticPage(),
      ShopPage()
    ];

  }

  void _onItemTapped(int index){
    _selectedIndex = index;
    _pageController.jumpToPage(index);
    setState(() {

    });
  }

  void _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image.asset(_selectedIndex==0?'assets/images/home/icon_Order_s.png':'assets/images/home/icon_Order_n.png'),
                title: Text('订单')
            ),
            BottomNavigationBarItem(
                icon: Image.asset(_selectedIndex==1?'assets/images/home/icon_commodity_s.png':'assets/images/home/icon_commodity_n.png'),
                title: Text('商品')
            ),
            BottomNavigationBarItem(
                icon: Image.asset(_selectedIndex==2?'assets/images/home/icon_statistics_s.png':'assets/images/home/icon_statistics_n.png'),
                title: Text('统计')
            ),
            BottomNavigationBarItem(
                icon: Image.asset(_selectedIndex==3?'assets/images/home/icon_Shop_s.png':'assets/images/home/icon_Shop_n.png'),
                title: Text('店铺')
            ),

          ],

        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 5.0,
        iconSize: 21.0,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        unselectedItemColor: Color(0xffbfbfbf),
        selectedItemColor: YJColors.app_main,
        
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        
      ),

      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pageList,
        physics: NeverScrollableScrollPhysics(),
      ),

    );
  }
}
