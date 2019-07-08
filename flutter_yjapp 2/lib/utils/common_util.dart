import 'package:flutter/material.dart';
import 'package:flutter_yjapp/config/colors_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'toast_util.dart';

class YJUtil {
  static Widget line = Divider(
    height: 0.8,
    color: YJColors.line,
  );

  static void langchTelUrl(String phone) async {
    String url = 'tel:' + phone;
    if(await canLaunch(url)){
      await launch(url);
    }else{
      Toast.show('拨号失败');
    }
  }

}
