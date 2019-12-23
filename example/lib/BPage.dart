import 'package:flutter/material.dart';

/// Created by liSen on 2019/12/23 15:58.
/// @author liSen < 453354858@qq.com >

class BPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BPageState();
  }
}

class BPageState extends State<BPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BPage"),),
      backgroundColor: Colors.amber,
      body: Column(
        children: <Widget>[
          Center(
            child: Text("当前是BPage页面")),
          RaisedButton(
            onPressed: (){
              Navigator.pop(context);
            },
              child: Text("关闭")),
        ],
      ),
    );
  }
}