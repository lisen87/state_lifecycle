# [state_lifecycle](https://github.com/lisen87/state_lifecycle)

监听页面被其他页面覆盖状态（onPause）或者页面正在展示中的状态（onReTop）,不包含 app 按下home键切换到后台的监听
The monitoring page is covered by other pages (onPause) or the page is being displayed (onReTop), excluding the app. Press the home button to switch to background monitoring
> Supported  Platforms
> * Android
> * iOS

## How to Use

```yaml
# add this line to your dependencies
state_lifecycle: ^1.0.0
```

```dart
import 'package:state_lifecycle/state_lifecycle.dart';
```
## 思路：通过`navigatorObservers`监听路由跳转状态，通过 `navigatorObservers`中`didPop`和`didPush`中Route参数获取路由名称，从而监听页面状态
## Idea: Monitor route status via `navigatorObservers`, and obtain route names via` didPop` and `didPush` in` navigatorObservers` to monitor page status

# Step 1:
在启动app的 MyApp 中 设置 `navigatorObservers`
正确填写`StateNavigatorObserver("MyHomePage")`中的路由名称可以使根页面监听到页面状态,填写错误只会影响根页面无法监听页面状态，并不会影响其他页面

```yaml

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        /// example => StateNavigatorObserver("MyHomePage"),
        StateNavigatorObserver("your home page name"),
      ],
      
      home: MyHomePage(title: ''),
    );
  }
}

```
* 没有使用`onGenerateRoute`就无需关心此处

当使用`onGenerateRoute`时，配置的`initialRoute: "MyHomePage" ` 要和 `StateNavigatorObserver("MyHomePage")`中的路由名称一致
填写错误只会影响根页面无法监听页面状态，并不会影响其他页面

```yaml

       // => Navigator.pushNamed(context, "APage");
       
       //或者使用 onGenerateRoute
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == "MyHomePage") {
            ## 如果想要页面跳转动画请参照RouterManager.normalRoute 返回动画路由即可
            return RouterManager.normalRoute(MyHomePage(
              title: "Flutter Demo Home Page",
            ));
          } else if (settings.name == "APage") {
            return RouterManager.normalRoute(APage());
          }
          return null;
        },
        initialRoute: "MyHomePage",

```

# Step 2:
打开新页面 
## [注意：打开方式错误将无法监听到页面的状态](https://github.com/lisen87/state_lifecycle)

```yaml

//使用此方法打开新页面，如果想要页面跳转动画请参照RouterManager.normalRoute 返回动画路由即可
Navigator.push(context, RouterManager.normalRoute(APage()));

//或者 使用此方法打开新页面
RouterManager.push(context, APage());

//或者 此方式需要配置 routes:{}
Navigator.pushNamed(context, "APage");

```

# Step 3:
在需要监听状态的state中`with LifecycleMixin`

```yaml
class APageState extends State<APage> with LifecycleMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("我是A页面")),
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
```








