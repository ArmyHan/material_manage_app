import 'package:flutter/material.dart';
import 'package:material_manage_app/models/UserModel.dart';
import 'package:material_manage_app/views/DrawerPage.dart';
import 'package:material_manage_app/views/ListPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = new UserModel("吴建川", "leyansorosame@gmail.com");
    return new Scaffold(
      appBar: new AppBar(title: new Text("物资管理")),
      drawer: new DrawerPage(user: user),
      body: new TabBarView(controller: controller, children: <Widget>[
        new ListPage(),
        new ListPage(),
        new ListPage(),
      ]),
      bottomNavigationBar: new Material(
        color: Colors.blue,
        child: new TabBar(controller: controller, tabs: <Tab>[
          new Tab(icon: new Icon(Icons.art_track)),
          new Tab(icon: new Icon(Icons.message)),
          new Tab(icon: new Icon(Icons.shopping_cart)),
        ]),
      ),
    );
  }
}
