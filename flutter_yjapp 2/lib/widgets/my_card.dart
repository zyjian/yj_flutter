import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {

  MyCard({
    Key key,
    this.color:Colors.white,
    this.shawowColor:const Color(0x80DCE7FA),
    @required this.child
  }):super(key:key);


  final Widget child;
  final Color color;
  final Color shawowColor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            color: shawowColor,
            offset: Offset(2.0, 2.0),
            blurRadius: 8.0,
            spreadRadius: 0,
          )
        ],
        borderRadius: BorderRadius.circular(5.0)
      ),

      child: child,
    );
  }
}
