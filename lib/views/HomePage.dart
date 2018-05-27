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
        new ListPage(title: "武汉物资管理系统1"),
        new ListPage(title: "武汉物资管理系统2"),
        new ListPage(title: "武汉物资管理系统3"),
      ]),
      bottomNavigationBar: new Material(
        color: Colors.blue,
        shadowColor: Colors.blue,
        elevation: 4.0,
        child: new TabBar(controller: controller, tabs: <Tab>[
          new Tab(text: "列表1", icon: new Icon(Icons.list)),
          new Tab(text: "列表2", icon: new Icon(Icons.list)),
          new Tab(text: "列表3", icon: new Icon(Icons.list)),
        ]),
      ),
    );
  }
}
