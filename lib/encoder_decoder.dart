import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:core';

class EncodeDecode extends StatefulWidget {
  @override
  _EncodeDecodeState createState() => _EncodeDecodeState();
}

enum Selection { encode, decode }

class _EncodeDecodeState extends State<EncodeDecode> {
  Selection option = Selection.encode;

  var firstText = TextEditingController();
  var result = TextEditingController();

  void _handleRadioValueChanged(Selection value) {
    option = value;
    setState(() {});
    result.clear();
    firstText.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int index;
  @override
  Widget build(BuildContext context) {
    index = DefaultTabController.of(context).index;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          encodeDecodeRow(),
          firstTextWidget(index),
          Divider(),
          TextField(
            readOnly: true,
            controller: result,
            maxLines: 5,
            onTap: () {
              if (result.text != '' && result.text != null) {
                Clipboard.setData(ClipboardData(text: result.text));
                final scaffold = Scaffold.of(context);
                scaffold.showSnackBar(
                  SnackBar(
                    content: const Text('Copied to clipboard'),
                    action: SnackBarAction(
                        label: 'Hide', onPressed: scaffold.hideCurrentSnackBar),
                  ),
                );
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Result',
            ),
          ),
          Text(
            'Hint: Click the result to copy it to your clipboard.',
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget firstTextWidget(index) {
    TextInputType inputType = TextInputType.multiline;
    if (index == 1 || index == 2 || index == 3) {
      inputType = TextInputType.multiline;
    } else {
      inputType = TextInputType.text;
    }
    return TextField(
      focusNode: FocusNode(),
      keyboardType: inputType,
      controller: firstText,
      maxLines: 5,
      onChanged: (value) {
        if (value == '') {
          result.text = '';
        } else {
          result.text = encodeDecode(value, option, index);
        }

        setState(() {});
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Introduce your text here',
      ),
    );
  }

  String encodeDecode(value, option, index) {
    if (value != '') {
      String textResult;
      if (option == Selection.encode) {
        switch (index) {
          case 0:
            textResult = Uri.encodeComponent(value);
            break;
          case 1:
            var bytes = utf8.encode(value);
            textResult = base64Encode(bytes);
            break;
          case 2:
            var bytes = utf8.encode(value);
            var convertedText = md5.convert(bytes);
            textResult = convertedText.toString();
            break;
          case 3:
            var bytes = utf8.encode(value);
            var convertedText = sha256.convert(bytes);
            textResult = convertedText.toString();
            break;
        }
      } else {
        switch (DefaultTabController.of(context).index) {
          case 0:
            textResult = Uri.decodeComponent(value);
            break;
          case 1:
            var x = base64Decode(value);
            textResult= utf8.decode(x);
            //textResult = convert.base64Decode(value).toString();
            break;
        }
      }
      return textResult;
    }else
    {
      return '';
    }
  }

  Widget encodeDecodeRow() {
    if (index == 0 || index == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio(
              value: Selection.encode,
              groupValue: option,
              onChanged: _handleRadioValueChanged),
          Text(
            'Encode',
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
          Radio(
              value: Selection.decode,
              groupValue: option,
              onChanged: _handleRadioValueChanged),
          Text(
            'Decode',
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      );
    } else {
      return Container(
        child: Text(
          'Hash',
          style: TextStyle(
            letterSpacing: 10.0,
              fontFamily: 'Quicksand',
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      );
    }
  }
}