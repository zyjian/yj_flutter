import 'dart:math';
import 'package:flutter/material.dart';

//https://github.com/alibaba/flutter-go/blob/master/lib/views/fourth_page/page_reveal.dart

class MenuReveal extends StatelessWidget {

  MenuReveal({
    Key key,
    this.revealPercent,
    this.child
  }):super(key:key);

  final double revealPercent;
  final Widget child;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipOval(
      clipper: CircelRevealClipper(revealPrecent: revealPercent),
      child: child,
    );
  }
}


class CircelRevealClipper extends CustomClipper<Rect> {
  CircelRevealClipper({
    this.revealPrecent
  });
  final double revealPrecent;

  @override
  Rect getClip(Size size) {
    // TODO: implement getClip
    // 右上角的点击点为圆心
    final epicenter = new Offset(size.width-25.0, 25.0);

    double theta = atan(epicenter.dy/epicenter.dx);
    final distanceToCorner = (epicenter.dy)/sin(theta);

    final radius = distanceToCorner * revealPrecent;
    final diameter = 2 * radius;
    return new Rect.fromLTWH(epicenter.dx - radius, epicenter.dy - radius, diameter, diameter);

  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}




