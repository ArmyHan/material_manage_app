import 'package:flutter/material.dart';
import 'package:material_manage_app/models/UserModel.dart';
import 'package:material_manage_app/util/MessageUtils.dart';
import 'package:material_manage_app/views/DrawerPage.dart';
import 'package:material_manage_app/views/MessageListPage.dart';
import 'package:material_manage_app/views/StorageInventoryListPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.user}) : super(key: key);
  final UserModel user;

  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
       MessageUtils.connect();
    }
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getBody();
  }

  _getBody() {
    if (widget.user == null) {
      return Scaffold(
        appBar: AppBar(title: Text("物资管理")),
        body: Center(
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
              child: Text("去登录"),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0))),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/login');
            },
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text("物资管理")),
        drawer: DrawerPage(user: widget.user),
        body: TabBarView(controller: controller, children: <Widget>[
          new StorageInventoryListPage(),
          new MessageListPage(),
          new StorageInventoryListPage(),
        ]),
        bottomNavigationBar: Material(
          color: Colors.blue,
          child: TabBar(controller: controller, tabs: <Tab>[
            new Tab(icon: Icon(Icons.category)),
            new Tab(icon: Icon(Icons.message)),
            new Tab(icon: Icon(Icons.shopping_cart)),
          ]),
        ),
      );
    }
  }
}
