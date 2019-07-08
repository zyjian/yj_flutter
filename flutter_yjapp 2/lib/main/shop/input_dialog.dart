import 'package:flutter/material.dart';
import 'package:flutter_yjapp/config/header_config.dart';
import 'package:flutter_yjapp/widgets/base_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yjapp/utils/number_text_input_formatter.dart';
import 'package:flutter_yjapp/utils/utils_header.dart';

class InputDialog extends StatefulWidget {
  InputDialog({
    Key key,
    @required this.textValue,
    @required this.title
  }):super(key:key);

  final double textValue;
  final String title;

  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {

  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.textValue!=0){
      _editingController.text = widget.textValue.toString();
    }
  }

  void pressDown(){
    if(_editingController.text.isEmpty){
      Toast.show('请输入${widget.title}');
      return;
    }
    Navigator.pop(context,double.parse(_editingController.text));
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MyBaseDialog(
        title: '${widget.title}',
        onPress: pressDown,
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: YJColors.bg_color,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: TextField(
            decoration: InputDecoration(

              hintText: '请输入${widget.title}',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 8.0),

            ),

            controller: _editingController,
            style: TextStyle(fontSize: 13.0,color: YJColors.text_dark),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            autofocus: true,
            inputFormatters: [
              UsNumberTextInputFormatter(),
            ],

          ),
        ),
        hiddenTitle: false
    );
  }
}