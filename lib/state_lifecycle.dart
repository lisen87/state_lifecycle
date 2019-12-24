import 'package:flutter/material.dart';

class StateLifecycleManager {
  factory StateLifecycleManager() {
    return _getInstance();
  }

  static StateLifecycleManager _instance = StateLifecycleManager._();

  static StateLifecycleManager get instance => _instance;

  // 静态、同步、私有访问点
  static StateLifecycleManager _getInstance() {
    return _instance;
  }

  Map<String,LifecycleMixin> _map;

  StateLifecycleManager._() {
    _map = Map();
  }

  onReTop(String routerName) {
    if(_map.containsKey(routerName)){
      _map[routerName].onReTop(routerName);
    }
  }
  onPause(String routerName) {
    if(_map.containsKey(routerName)){
      _map[routerName].onPause(routerName);
    }
  }

  ///添加
  addLifecycle(LifecycleMixin lifecycleMixin) {
    if (!_map.containsValue(lifecycleMixin)) {
      _map[lifecycleMixin.widget.runtimeType.toString()] = lifecycleMixin;
    }
  }

  ///移除
  removeLifecycle(LifecycleMixin lifecycleMixin) {
    if (_map.containsValue(lifecycleMixin)) {
      _map.remove(lifecycleMixin.widget.runtimeType.toString());
    }
  }
}

class StateNavigatorObserver extends NavigatorObserver {

  String homePageName;

  StateNavigatorObserver(this.homePageName);

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    String routerName = previousRoute?.settings?.name;
    if(routerName != null && "/" == routerName){
      /// 首页
      routerName = homePageName;
    }
    if(routerName != null){
      Future.delayed(Duration(milliseconds: 100),(){
        StateLifecycleManager.instance.onReTop(routerName);
      });
    }
  }

  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    String routerName = previousRoute?.settings?.name;
    if(routerName != null && "/" == routerName){
      /// 首页
      routerName = homePageName;
    }
    if(routerName != null){
      Future.delayed(Duration(milliseconds: 100),(){
        StateLifecycleManager.instance.onPause(routerName);
      });
    }
  }
}

mixin LifecycleMixin <T extends StatefulWidget> on State<T> {
  @mustCallSuper
  @override
  void initState() {
    super.initState();
    StateLifecycleManager.instance.addLifecycle(this);
  }

  @mustCallSuper
  @override
  void dispose() {
    StateLifecycleManager.instance.removeLifecycle(this);
    super.dispose();
  }

  ///页面回到正在展示状态
  @protected
  void onReTop(String routerName);

  ///页面处于非正在展示中
  @protected
  void onPause(String routerName);
}

class RouterManager {


  /// RouterManager.push(context, APage());

  static push(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) {
            return widget;
          },
          settings: RouteSettings(name: widget.runtimeType.toString())),
    );
  }

  /// Navigator.push(context, RouterManager.normalRoute(APage()));
  /// Navigator.of(context).push(RouterManager.normalRoute(APage()));

  static Route<dynamic> normalRoute(Widget widget) {
    return MaterialPageRoute(
        builder: (context) {
          return widget;
        },
        settings: RouteSettings(name: widget.runtimeType.toString()));
  }

  RouterManager._();
}
