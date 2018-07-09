## Flutter小工具

### 实现登录功能
> 为避免用户通过登录界面登录应用后按返回键仍能回到登录界面，我们需要在用户登录后创建一个新的路由栈

直接上代码，程序入口：

```dart
void main() {
  DataUtils.getUserInfo().then((userInfo) {
    runApp(MyApp(userInfo));
  });
}

class MyApp extends StatelessWidget {
  MyApp(this.userModel);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    return MaterialApp(
      title: 'MaterialManagement',
      theme: ThemeData(accentColor: Colors.white, primaryColor: Colors.blue),
      home: userModel == null
          ? LoginPage()
          : HomePage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => HomePage()
      },
    );
  }
}
```
现在我们要定义一个 `loginButton` 的 `onPressed` 事件的回调函数 `_loginWithAvatarAndPassword` 来完成重新创建路由栈的工作，这样就可以避免在登录成功后按返回键回到登录界面的问题（注销同理）：
```dart
Future<dynamic> _loginWithAvatarAndPassword() async {
        final form = _formKey.currentState;
        if (form.validate()) {
          _formKey.currentState.save();
          LoginUtils.login(user.avatar, user.password, (isAlive, userInfo) {
            if (isAlive) {
              runApp(MyApp(userInfo)); // look here!
            }
          });
        }
    }
```

---

### 实现双击退出应用功能
>  `WillPopScope` 注册一个回调 `onWillPop` 用来自定义用户对路由的操作

自定义我们的回调函数，
```dart
Future<bool> _doubleExit() {
    int nowTime = new DateTime.now().microsecondsSinceEpoch;
    if (_lastClickTime != 0 && nowTime - _lastClickTime > 1500) {
      return new Future.value(true);
    } else {
      _lastClickTime = new DateTime.now().microsecondsSinceEpoch;
      new Future.delayed(const Duration(milliseconds: 1500), () {
        _lastClickTime = 0;
      });
      return new Future.value(false);
    }
  }
```

将事先创建好的子节点 `_getBody()` 嵌套在 `WillPopScope` 中
```dart
Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _doubleExit, // look here!
      child: _getBody(),
    );
  }
```

### 下拉刷新

> 很简单，直接使用 `RefreshIndicator` 组件， `onRefresh` 为重新获取数据的方法

```dart
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(2.0),
        child: RefreshIndicator(
          onRefresh: _refresh,
          backgroundColor: Colors.blue,
          child: ListView.builder(
                  itemCount: _dataList.length,
                  itemBuilder: (context, index) {
                      return ListItem(_dataList[index]);
                  },
                ),
        ),
      ),
    );
  }
  
  Future<Null> _refresh() async {
    _dataList.clear();
    await _loadFirstListData();
    return;
  }
```

### 上拉加载更多

让我们先从最原始的十条的数据开始

```dart
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> items = List.generate(10, (i) => i);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Infinite ListView"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(title: new Text("Number $index"));
        },
      ),
    );
  }
}
```

---

现在我们要编写一个加载更多数据的方法，用来模拟 `http` 请求

```dart
Future<List<int>> fakeRequest(int from, int to) async {
 return Future.delayed(Duration(seconds: 2), () {
   return List.generate(to - from, (i) => i + from);
 });
}
```

---

现在我们想要让用户将 `ListView` 滑动到最末端的触发 `fakeRequest` 来加载更多数据，最简单的实现方式就是使用 `ScrollController` 来完成，`ScrollController` 会监听滚动事件，当 `ListView` 滚动到末端的时候他会发出一个请求。在这里还有一件需要注意的事就是为了避免对服务器不断地请求，我们需要做一个标记 `isPerformingRequest ` 只有当它为 `false` 的时候才允许对后台进行请求。

```dart
class _MyHomePageState extends State<MyHomePage> {
  List<int> items = List.generate(10, (i) => i);
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<int> newEntries = await fakeRequest(items.length, items.length + 10);
      setState(() {
        items.addAll(newEntries);
        isPerformingRequest = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Infinite ListView"),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(title: new Text("Number $index"));
        },
        controller: _scrollController,
      ),
    );
  }
}
```

如果你现在运行程序你将会看到我们的列表已经可以实现动态加载了，但是这距离我们的目标还很远，我们需要添加一些标志动作让用户这道请求已经开始。

---

接下来我们要用到 `CircularProgressIndicator` 去完成这个加载标志

```dart
Widget _buildProgressIndicator() {
  return new Padding(
    padding: const EdgeInsets.all(8.0),
    child: new Center(
      child: new Opacity(
        opacity: isPerformingRequest ? 1.0 : 0.0,
        child: new CircularProgressIndicator(),
      ),
    ),
  );
}
```
现在我们将这个加载标志放到我们的 `ListView` 中去，注意这里要给 `itemCount` 加出一块空间来放置我们的 `_buildProgressIndicator` 

```dart
@override
Widget build(BuildContext context) {
  return new Scaffold(
    appBar: AppBar(
      title: Text("Infinite ListView"),
    ),
    body: ListView.builder(
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length) {
          return _buildProgressIndicator();
        } else {
          return ListTile(title: new Text("Number $index"));
        }
      },
      controller: _scrollController,
    ),
  );
}
```

到这里加载更多数据的功能基本完成了，为了更加美观我们还要处理当没有请求到更多数据的时候动作，在这里我们添加一个动画没有更多数据的时候 `ListView` 向下移动覆盖正在加载更多数据的标志

```dart
_getMoreData() async {
  if (!isPerformingRequest) {
    setState(() => isPerformingRequest = true);
    List<int> newEntries = await fakeRequest(items.length, items.length); //returns empty list
    if (newEntries.isEmpty) {
      double edge = 50.0;
      double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
      if (offsetFromBottom < edge) {
        _scrollController.animateTo(
            _scrollController.offset - (edge -offsetFromBottom),
            duration: new Duration(milliseconds: 500),
            curve: Curves.easeOut);
      }
    }
    setState(() {
      items.addAll(newEntries);
      isPerformingRequest = false;
    });
  }
}
```

> 来看一看效果吧

<img src="https://github.com/leyan95/material_manage_app/blob/master/assets/screen_gif/loadMore.gif" width="25%" />



### 与WebSocket通讯实现消息推送
