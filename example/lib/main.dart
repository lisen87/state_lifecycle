import 'package:example/APage.dart';
import 'package:example/BPage.dart';
import 'package:flutter/material.dart';
import 'package:state_lifecycle/state_lifecycle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: [
        StateNavigatorObserver("MyHomePage"),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

//      routes: {
//        "APage": (context) {
//          return APage();
//        },
//        "BPage": (context) {
//          return BPage();
//        },
//        "MyHomePage": (context) {
//          return MyHomePage(title : "11");
//        },
//      },

      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == "MyHomePage") {
          return RouterManager.normalRoute(MyHomePage(
            title: "Flutter Demo Home Page",
          ));
        } else if (settings.name == "APage") {
          return RouterManager.normalRoute(APage());
        }
        return null;
      },
      initialRoute: "MyHomePage",
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with LifecycleMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                onPressed: () {
                  Navigator.push(context, RouterManager.normalRoute(APage()));
//                  Navigator.pushNamed(context, "APage");
//                  Navigator.push(context, new MaterialPageRoute(
//                      builder: (context) {
//                        return APage();
//                      },),);
                },
                child: Text("打开APage")),
          ],
        ),
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
