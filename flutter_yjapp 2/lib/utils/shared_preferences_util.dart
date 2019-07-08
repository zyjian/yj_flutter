import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesUtil {
  static set(String key ,String value) async{
    SharedPreferences prefes = await SharedPreferences.getInstance();
    await prefes.setString(key, value);
  }

}

