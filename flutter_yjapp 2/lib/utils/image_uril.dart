import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'path_util.dart';


/// 加载本地资源图片
Widget loadAssetImage(@required String name, {double width, double height, BoxFit fit}){
  return Image.asset(
    PathUtil.getImgPath(name),
    height: height,
    width: width,
    fit: fit,
  );
}


//加载网络图片
Widget loadNetworkImage(@required String imgUrl,{double width,double height ,BoxFit fix:BoxFit.cover}){
  return CachedNetworkImage(
    height: height,
    width: width,
    imageUrl: imgUrl,
    placeholder: (BuildContext context,String url){
      return loadAssetImage('none',width: width,height: height,fit: fix);
    },
    errorWidget: (context,url,error){
      return loadAssetImage("none", height: height, width: width, fit: fix);
    },

    fit: fix,
  );

}
