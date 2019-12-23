import 'package:example/BPage.dart';
import 'package:flutter/material.dart';
import 'package:state_lifecycle/state_lifecycle.dart';

/// Created by liSen on 2019/12/23 15:58.
/// @author liSen < 453354858@qq.com >

class APage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return APageState();
  }
}

class APageState extends State<APage> with LifecycleMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("APage"),),
      backgroundColor: Colors.green,
      body: Center(
        child: RaisedButton(onPressed: (){
//          Navigator.push(context, RouterManager.normalRoute(BPage()));
//          RouterManager.push(context, BPage());
          Navigator.push(context, new MaterialPageRoute(
                      builder: (context) {
                        return BPage();
                      },),);
        }, child: Text("跳转到BPage页面")),
      ),
    );
  }

  @override
  void onPause(String routerName) {
    print(routerName + " 暂停状态");
  }

  @override
  void onReTop(String routerName) {
    print(routerName + ' 正在显示状态');
  }
}