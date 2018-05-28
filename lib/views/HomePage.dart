import 'package:flutter/material.dart';
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
    return new Scaffold(
      body: new TabBarView(controller: controller, children: <Widget>[
        new ListPage(title: "动态"),
        new ListPage(title: "创建"),
        new ListPage(title: "购物车"),
      ]),
      bottomNavigationBar: new Material(
        color: Colors.blue,
        child: new TabBar(controller: controller, tabs: <Tab>[
          new Tab(icon: new Icon(Icons.art_track)),
          new Tab(icon: new Icon(Icons.add_circle)),
          new Tab(icon: new Icon(Icons.shopping_cart)),
        ]),
      ),
    );
  }
}
