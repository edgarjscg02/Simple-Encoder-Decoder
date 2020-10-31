import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:core';
import 'encoder_decoder.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                  child: Icon(FontAwesomeIcons.slackHash)),
              Text(
                'Encoder-Decoder-Hasher',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 15.0,
                  letterSpacing: 3.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'URL',
              ),
              Tab(
                text: 'Base64',
              ),
              Tab(
                text: 'MD5',
              ),
              Tab(
                text: 'SHA-256',
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            EncodeDecode(),
            EncodeDecode(),
            EncodeDecode(),
            EncodeDecode(),
            //RollDices(),
            // RandomNumber(),
            //RandomFromList(),
          ],
        ),
      ),
    );
  }
}