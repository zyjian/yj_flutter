import 'package:flutter/material.dart';
import 'package:flutter_yjapp/widgets/my_flexible_space_bar.dart';
import 'package:flutter_yjapp/utils/utils_header.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yjapp/widgets/my_card.dart';

class StatisticPage extends StatefulWidget {

  @override
  _StatisticPageState createState() => _StatisticPageState();

}
class _StatisticPageState extends State<StatisticPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: MyFlexibleSpaceBar(
              title: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text('统计'),
              ),
              centerTitle: true,
              background: loadAssetImage(
                'statistic/statistic_bg',
                height: 115.0,
                fit: BoxFit.fill
              ),

            ),
            expandedHeight: 100.0,
            pinned: true,
            brightness: Brightness.dark,

          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegate(
                height: 120.0,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(PathUtil.getImgPath('statistic/statistic_bg1')),
                        fit: BoxFit.fill
                      ),
                    ),

                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: MyCard(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              _buildStatisticsTab("新订单(单)", "statistic/xdd", "80"),
                              _buildStatisticsTab("待配送(单)", "statistic/dps", "80"),
                              _buildStatisticsTab("今日交易额(元)", "statistic/jrjye", "8000.00"),
                            ],
                          ),
                        ),

                    ),
                  ),

                )
            ),
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 30.0,),
                  Text('数据走势',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10.0,),
                  _buildStatisticsItem("订单统计", "sjzs", 1),
                  SizedBox(height: 10.0,),
                  _buildStatisticsItem("交易额统计", "jyetj", 2),
                  SizedBox(height: 10.0,),
                  _buildStatisticsItem("商品统计", "sptj", 3),

                ],
              ),
            ),
          )
          

        ],
      ),
    );
  }

  Widget _buildStatisticsTab(String title, String img, String content){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        loadAssetImage(img,width: 40.0),
        SizedBox(height: 5.0,),
        Text(title,style: TextStyle(fontSize: 13,color: YJColors.text_gray),),
        SizedBox(height: 5.0,),
        Text(content,style: TextStyle(fontSize: 18.0,color: YJColors.text_dark),),
      ],
    );
  }

  Widget _buildStatisticsItem(String title, String img, int index){
    return AspectRatio(
      aspectRatio: 2.14,
      child:MyCard(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: (){

            },

            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(title, style: TextStyle(fontSize: 16.0,color: YJColors.text_dark,fontWeight: FontWeight.bold)),
                    loadAssetImage("statistic/icon_selected", height: 16.0, width: 16.0)
                  ],
                ),
                Expanded(
                  child: loadAssetImage("statistic/$img", fit: BoxFit.fill),
                )
              ],
            ),
          ),
        ),
      ) ,
    );
  }

}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate({
    this.height,
    this.child
  });

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return child;
  }
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
  @override
  // TODO: implement minExtent
  double get minExtent => height;

  @override
  // TODO: implement maxExtent
  double get maxExtent => height;

}

