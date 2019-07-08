import 'package:flutter/services.dart';

// 只允许输入两位小数
class UsNumberTextInputFormatter extends TextInputFormatter {
  static const defaultDouble = 0.001;

  static double str2Float(String str,[double defaultValue = defaultDouble]){
    try{
      return double.parse(str);
    }catch(e){
      return defaultValue;
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    String value = newValue.text;
    String old = oldValue.text;
    if(value.isEmpty){

      return TextEditingValue(
        text: '',
        selection: new TextSelection.collapsed(offset: 0),
      );
    }

    RegExp reg = RegExp('[0-9]+.[0-9]{0,2}|[0-9]+');
    var res = reg.stringMatch(value);
    return TextEditingValue(
      text: res,
      selection: new TextSelection.collapsed(offset: res.length),
    );
  }
}

